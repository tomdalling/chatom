# frozen_string_literal: true

module Ashtu
  module AST
    extend self

    def parse_xml(xml)
      parse_element(Ox.parse(xml.strip))
    end

    def parse_element(element, node_class = nil)
      node_class ||= AST.const_get(element.value)
      node_class.from_xml_element(element)
    end

    def parse_child_element(parent, child_tag, node_class = nil)
      children = parent.nodes.select { _1.is_a?(Ox::Element) && _1.value == child_tag }
      if children.size != 1
        raise "Expected to find one #{child_tag}, but found #{children.size}"
      end

      parse_element(children.first, node_class)
    end

    def parse_element_text(element)
      children = element.nodes
      if children.size != 1
        raise "Expected to find only text, but found children: #{children.map(&:class).inspect}"
      end

      children.first.strip
    end
  end
end
