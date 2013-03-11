defmodule Dynamo.Templates.MDHandler do
  @moduledoc false
  @behaviour Dynamo.Templates.Handler

  def compile(Dynamo.Template[identifier: identifier], source, locals) do
    :io.format("compile ~p ~p ~n", [identifier, source])
    vars = vars(locals)
    args = [{ :assigns, [], nil}|vars]
    match = match(args)
    source = :markdown.conv_utf8(source)
#    source = EEx.compile_string(source, file: idnetifier)
    source = EEx.compile_string(source)
    {
      args, quote do
	unquote_splicing(match)
	body = unquote(source)
	{ unquote(vars), body}
      end }
  end
  def render(module, function, locals, assigns) do
    :io.format("render ~p ~p ~n", [module, function])
    apply module, function, [assigns|Keyword.values(locals)]
  end
  defp vars(locals) do
    lc name inlist locals, do: {name, [], nil}
  end
  defp match(locals) do
    lc var inlist locals, do: { :=, [], [{ :_, [], nil }, var]}
  end
end
