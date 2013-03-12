defmodule Dynamo.Templates.MDHandler do
  @moduledoc false
  @behaviour Dynamo.Templates.Handler

  def compile(Dynamo.Template[identifier: identifier], source, locals) do
    vars = vars(locals)
    args = [{ :assigns, [], nil}|vars]
    match = match(args)
    source = list_to_binary(:markdown.conv_utf8(binary_to_list(source)))
#    source = EEx.compile_string(source, file: identifier)
    {
      args, quote do
	unquote_splicing(match)
	body = unquote(source)
	{ unquote(vars), body}
      end }
  end
  def render(module, function, locals, assigns) do
    apply module, function, [assigns|Keyword.values(locals)]
  end
  defp vars(locals) do
    lc name inlist locals, do: {name, [], nil}
  end
  defp match(locals) do
    lc var inlist locals, do: { :=, [], [{ :_, [], nil }, var]}
  end
end
