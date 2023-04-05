defmodule Servy.BearController do
  alias Servy.Bear

  import Servy.View, only: [render: 3]
  alias Servy.Wildthings

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name(&1, &2))
      |> Enum.join()

    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do
    bear =
      id
      |> String.replace("/", "")
      |> Wildthings.get_bear()

    render(conv, "show.eex", bear: bear)
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{
      conv
      | status: 201,
        resp_body: "Create a #{type}bear named #{name}!"
    }
  end

  # def delete(conv, _params) do
  #   %{conv | status: 403, resp_body: "Deleting bear is forbidden!"}
  # end
end
