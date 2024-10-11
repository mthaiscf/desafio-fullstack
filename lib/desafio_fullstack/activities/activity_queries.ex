defmodule DesafioFullstack.Activities.ActivityQueries do

  @moduledoc """
    Esse módulo contém as queries referente a Activity
  """

  import Ecto.Query

  alias DesafioFullstack.Activities.Activity


  @spec get_by_city(any(), any()) :: Ecto.Query.t()
  def get_by_city(query \\ base(), city) do
    from(activities in query,
      where: activities.city == ^city
    )
  end

  @spec get_by_tags(any(), any()) :: Ecto.Query.t()
  def get_by_tags(query \\ base(), tags) do

    first_tag =  List.first(tags) # por enquanto so compara o primeiro elemento

    #SELECT * FROM activities a WHERE '{"esportes", "educativo"}' && a.tags; to do: ajustar query
    from(activities in query,
     where: ^first_tag in activities.tags
    )
  end

  @spec get_by_title(any(), any()) :: Ecto.Query.t()
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
