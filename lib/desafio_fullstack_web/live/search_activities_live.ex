defmodule DesafioFullstackWeb.SearchActivitiesLive do
  use Phoenix.LiveView

  alias DesafioFullstack.Activities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{activities_list: [], activity: get_surprise_activity(), show_modal: false, activities_list_lenght: 0, tags: [], title: ""})}
  end

  def handle_event("search_activities", %{"search_field" => search_field}, socket) do
    activities_list = Activities.search_activities(search_field, socket.assigns.tags)
    {:noreply, assign(socket, activities_list: activities_list, activities_list_lenght: length(activities_list))}
  end

  def handle_event("get_surprise_activity", _params, socket) do
    {:noreply, assign(socket, activity: get_surprise_activity())}
  end

  def handle_event("get_detail", _params, socket) do
    assign(socket, activity: get_surprise_activity())
    {:noreply, push_navigate(socket, to: "/detail")}
  end

  def handle_event("toggle_modal", _params, socket) do
    {:noreply, assign(socket, :show_modal, !socket.assigns.show_modal)}
  end

  def handle_event("toggle_tag", %{"tag" => tag}, socket) do
    tags = if tag in socket.assigns.tags do
      List.delete(socket.assigns.tags, tag)
    else
      [tag | socket.assigns.tags]
    end

    activities_list = Activities.search_activities(socket.assigns.title, tags)
    {:noreply, assign(socket, activities_list: activities_list, activities_list_lenght: length(activities_list), tags: tags)}
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
            border: 1px solid #ccc; /* Borda cinza */
            background-color: #d3d3d3; /* Fundo cinza */
            padding: 5px 10px; /* Espaçamento interno das tags */
            border-radius: 3px;
            font-size: 0.9rem;
            color: #333;
            margin-bottom: 5px; /* Espaçamento entre as linhas */
            cursor: pointer;
        }
        .tag.selected {
            background-color: #1E90FF; /* Cor azul quando selecionada */
            color: white; /* Texto branco quando selecionada */
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
        .modal {
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }
        .modal-content {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            position: relative;
            max-width: 500px;
            width: 90%;
        }
        .close-modal {
            position: absolute;
            top: 10px;
            right: 15px;
            cursor: pointer;
            font-size: 1.5rem;
            color: black;
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.2rem;
            margin-bottom: 10px;
        }
      </style>

      <script>
        function toggleTag(tag) {
            const tagElement = document.getElementById(tag);
            if (tagElement.classList.contains('selected')) {
                tagElement.classList.remove('selected');
            } else {
                tagElement.classList.add('selected');
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

        <a href="#" class="link-right" phx-click="toggle_modal">
          <Heroicons.funnel solid class="icon" />
          Categorias
        </a>
      </div>

      <!-- Modal -->
      <%= if @show_modal == true do %>
        <div id="categoryModal" class="modal">
          <div class="modal-content">
            <span class="close-modal" phx-click="toggle_modal">&times;</span>
            <div class="modal-header">
              <h2 style="font-size: 1rem; margin: 0;">Selecione uma categoria para filtrar as atividades listadas.</h2>
            </div>
            <div class="tags">
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Restaurante" id="Restaurante">Restaurante</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Boteco" id="Boteco">Boteco</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Bom para crianças" id="Bom para crianças">Bom para crianças</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Bom para grupos" id="Bom para grupos">Bom para grupos</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Bom para casais" id="Bom para casais">Bom para casais</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Bom para trabalhar" id="Bom para trabalhar">Bom para trabalhar</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Café" id="Café">Café</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Loja" id="Loja">Loja</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Shopping" id="Shopping">Shopping</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Ar livre" id="Ar livre">Ar livre</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Doces" id="Doces">Doces</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Salgados" id="Salgados">Salgados</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Hamburgueria" id="Hamburgueria">Hamburgueria</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Parque" id="Parque">Parque</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Praça" id="Praça">Praça</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Passeio" id="Passeio">Passeio</div>
              <div class="tag" phx-click="toggle_tag" phx-value-tag="Saúde" id="Saúde">Saúde</div>
            </div>
          </div>
        </div>
      <% end %>

    <form phx-change="search_activities" phx-submit="search_activities">
      <input class="input" type="text" name="search_field"/>
    </form>

    <%= if @activities_list_lenght > 0 do %>
      <div class="activity-count"><%= @activities_list_lenght %> Atividade(s) encontrada(s)</div>
    <% end %>

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
