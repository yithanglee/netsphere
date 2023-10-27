defmodule CommerceFront do
  @moduledoc """
  CommerceFront keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def get_order() do
    pid = Process.whereis(:rest_1)
    Agent.get(pid, fn x -> x end)
  end

  def add_order() do
    pid = Process.whereis(:rest_1)

    Agent.update(pid, fn list -> List.insert_at(list, 0, %{items: [%{name: "apple", qty: 1}]}) end)
  end
end
