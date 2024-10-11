defmodule DesafioFullstack.Activities.ActivityQueries do

  @moduledoc """
    Esse módulo contém as queries referente a Activity
  """

  import Ecto.Query

  alias DesafioFullstack.Activities.Activity


  def get_by_city(query \\ base(), city) do
    from(activities in query,
      where: activities.city == ^city
    )
  end

  def get_by_tag(query \\ base(), tag) do
    from(activities in query,
      where: ^tag in activities.tags
    )
  end

  def get_by_title(query \\ base(), title) do
    like = "%#{title}%"
    from(activities in query,
      where: like(activities.title, ^like)
    )
  end

  def get_random(query \\ base()) do
    from(activities in query,
      order_by: fragment("RANDOM()"),
      limit: 1
    )
  end

  defp base, do: Activity

end
