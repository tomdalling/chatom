import { Dictionary } from "./dictionary.js";
import { toIPA } from "./ipa.js";
import { parse as parseSentence } from "./parser.js";
import { serializeXml } from "./xml.js";

const statusEl = document.getElementById("status");

function setStatus(text) {
  statusEl.textContent = text;
}

function el(tag, props = {}, children = []) {
  const node = document.createElement(tag);
  for (const [key, value] of Object.entries(props)) {
    if (key === "className") node.className = value;
    else if (key === "textContent") node.textContent = value;
    else node.setAttribute(key, value);
  }
  for (const child of children) node.appendChild(child);
  return node;
}

function renderEntry(entry) {
  let ipa = null;
  try {
    ipa = toIPA(entry.word);
  } catch {
    ipa = null;
  }

  const head = el("div", { className: "entry-head" }, [
    el("span", { className: "entry-word", textContent: entry.word }),
    el("span", { className: "entry-pos", textContent: entry.partOfSpeech }),
    ...(ipa ? [el("span", { className: "entry-ipa", textContent: `/${ipa}/` })] : []),
  ]);

  const children = [head, el("div", { className: "entry-definition", textContent: entry.definition })];
  if (entry.description) {
    children.push(el("div", { className: "entry-description", textContent: entry.description }));
  }

  return el("div", { className: "entry" }, children);
}

function renderEntries(container, entries) {
  container.replaceChildren();
  if (entries.length === 0) {
    container.appendChild(el("p", { className: "empty-message", textContent: "No entries found." }));
    return;
  }
  entries.forEach((entry) => container.appendChild(renderEntry(entry)));
}

function renderError(container, message) {
  container.replaceChildren(el("p", { className: "error-message", textContent: message }));
}

function setupTabs() {
  const buttons = document.querySelectorAll(".tab-button");
  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      buttons.forEach((b) => b.setAttribute("aria-selected", String(b === button)));
      document.querySelectorAll(".tab-panel").forEach((panel) => {
        panel.classList.toggle("hidden", panel.id !== `tab-${button.dataset.tab}`);
      });
    });
  });
}

async function loadDictionary() {
  const response = await fetch("data/dictionary.txt");
  if (!response.ok) throw new Error(`Failed to load dictionary: HTTP ${response.status}`);
  const text = await response.text();
  return Dictionary.parse(text);
}

function main(dictionary) {
  setupTabs();

  document.getElementById("lookup-form").addEventListener("submit", (event) => {
    event.preventDefault();
    const word = document.getElementById("lookup-word").value.trim();
    const results = document.getElementById("lookup-results");
    if (!word) return renderEntries(results, []);
    const entry = dictionary.lookup(word);
    renderEntries(results, entry ? [entry] : []);
  });

  document.getElementById("search-form").addEventListener("submit", (event) => {
    event.preventDefault();
    const term = document.getElementById("search-term").value.trim();
    const results = document.getElementById("search-results");
    renderEntries(results, term ? dictionary.search(term) : []);
  });

  document.getElementById("list-form").addEventListener("submit", (event) => {
    event.preventDefault();
    const pos = document.getElementById("list-pos").value || null;
    const results = document.getElementById("list-results");
    renderEntries(results, dictionary.list({ pos }));
  });

  document.getElementById("parse-form").addEventListener("submit", (event) => {
    event.preventDefault();
    const sentence = document.getElementById("parse-sentence").value.trim();
    const results = document.getElementById("parse-results");
    if (!sentence) return results.replaceChildren();

    try {
      const clause = parseSentence(sentence, dictionary);
      const gloss = clause.toEnglishGloss(dictionary);
      const xml = serializeXml(clause.toXmlElement());
      results.replaceChildren(
        el("p", { className: "parse-gloss", textContent: gloss }),
        el("pre", { className: "parse-xml", textContent: xml }),
      );
    } catch (error) {
      renderError(results, `Error: ${error.message}`);
    }
  });

  // Show every dictionary entry by default on first load of the List tab.
  renderEntries(document.getElementById("list-results"), dictionary.list());

  setStatus(`${dictionary.entries.length} dictionary entries loaded.`);
}

loadDictionary()
  .then(main)
  .catch((error) => {
    setStatus(`Failed to load dictionary: ${error.message}. If you opened this file directly, serve it over HTTP instead (e.g. "python3 -m http.server").`);
  });
