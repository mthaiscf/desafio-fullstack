defmodule DesafioFullstackWeb.SearchActivitiesLive do

  use Phoenix.LiveView

  alias DesafioFullstack.Activities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{activities_list: Activities.get_by_city("Maceió"), activity: get_surprise_activity()})}
  end

  def handle_event("search_activities", %{"title" => title, "tags" => tags}, socket) do
    activities_list = Activities.search_activities(title, tags)
    {:noreply, assign(socket, activities_list: activities_list)}
  end

  def handle_event("get_surprise_activity", _params, socket) do
    {:noreply, assign(socket, activity: get_surprise_activity())}
  end

  def handle_event("get_detail", _params, socket) do
    assign(socket, activity: get_surprise_activity())
    {:noreply, push_navigate(socket, to: "/detail")}
  end

  def get_surprise_activity do
    Activities.get_random()
  end

  def render(assigns) do
    ~H"""
      <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: center;
            background-color: #f0f0f0;
            padding: 20px;
        }
        h1 {
            font-size: 2.5rem;
            color: black;
            margin-bottom: 20px;
        }
        .maceio {
            color: #1E90FF;
        }
        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 10px;
            width: 100%;
            max-width: 536px;
            padding: 0 10px;
        }
        .link-right {
            font-size: 1rem;
            color: #1E90FF;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        .icon {
            width: 20px;
            height: 20px;
            margin-right: 8px;
            display: inline-block;
        }
        .image-container {
            position: relative;
            max-width: 536px;
            margin-bottom: 20px;
            text-align: left;
        }
        img {
            max-width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 10px;
        }
        .title {
            position: absolute;
            bottom: 60px;
            left: 20px;
            padding: 2px 5px;
            border-radius: 2px;
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
        }
        .tag-container {
            position: absolute;
            bottom: 20px; /* Distância do fundo da imagem */
            left: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 5px; /* Espaçamento entre as tags */
        }
        .tag {
            display: inline-block;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 0.9rem;
            color: #333;
        }
        input {
            padding: 10px;
            font-size: 1rem;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 536px;
        }
        .result {
            margin-top: 10px;
            font-size: 1.2rem;
            color: #333;
        }
        .co-working {
            font-size: 0.9rem;
            color: black;
            margin-top: 5px;
            background-color: #d3d3d3;
            padding: 2px 5px;
            border-radius: 3px;
            display: inline-block;
            position: relative;
        }
        .remove-tag {
            margin-left: 5px;
            cursor: pointer;
            font-weight: bold;
            color: black;
        }
        .activity-count {
            font-size: 1rem;
            color: #333;
            margin-top: 5px;
            text-align: left;
            max-width: 536px;
            margin-left: 0px;
        }
      </style>

      <script>
        function removeTag() {
            const tag = document.getElementById('co-working-tag');
            if (tag) {
                tag.style.display = 'none';
            }
        }
      </script>

      <h1><strong>O que fazer em <span class="maceio">Maceió</span>?</strong></h1>

      <div class="section-title">
        <div>
          <Heroicons.sparkles solid class="icon" />
          <span>ATIVIDADE SURPRESA</span>
        </div>
        <a href="#" class="link-right" phx-click="get_surprise_activity">
          <Heroicons.arrow_path solid class="icon"/>
          Outra sugestão
        </a>
      </div>

      <div class="image-container" phx-click="get_detail">
        <img src="https://picsum.photos/536/354" alt="Imagem de Maceió">
        <div class="title"><strong><%= @activity.title %></strong></div>
        <!-- Container para as tags, posicionado abaixo do título -->
        <div class="tag-container">
          <%= for tag <- @activity.tags do %>
            <div class="tag"><%= tag %></div>
          <% end %>
        </div>
      </div>

      <div class="section-title">
        <div>
          <Heroicons.magnifying_glass solid class="icon" />
          <span>OUTRAS ATIVIDADES</span>
        </div>

        <a href="#" class="link-right">
          <Heroicons.funnel solid class="icon" />
          Categorias
        </a>
      </div>

      <form phx-change="change_note_text" phx-submit="search_activities">
        <div class="field">
          <label class="label" for="">
            <div class="control">
              <input class="input" type="text" name="search_field" autocomplete="off"/>
            </div>
          </label>
        </div>
      </form>

      <div class="activity-count">Atividade(s) encontrada(s)</div>

      <!-- Reaplicação do estilo de título e tags para cada atividade encontrada -->
      <%= for actv <- @activities_list do %>
        <div class="image-container">
          <img src="https://picsum.photos/536/200" alt="Imagem atividade" phx-click="get_detail">
          <div class="title"><strong><%= actv.title %></strong></div>
          <div class="tag-container">
            <%= for t <- actv.tags do %>
              <div class="tag"><%= t %></div>
            <% end %>
          </div>
        </div>
      <% end %>
    """
  end
end
