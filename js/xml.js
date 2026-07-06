export function xmlElement(tag, textOrChildren) {
  if (typeof textOrChildren === "string") {
    return { tag, text: textOrChildren, children: [] };
  }
  return { tag, text: null, children: textOrChildren ?? [] };
}

export function serializeXml(node, depth = 0) {
  const indent = "  ".repeat(depth);
  if (node.text !== null) {
    return `${indent}<${node.tag}>${node.text}</${node.tag}>`;
  }
  const inner = node.children.map((child) => serializeXml(child, depth + 1)).join("\n");
  return `${indent}<${node.tag}>\n${inner}\n${indent}</${node.tag}>`;
}
