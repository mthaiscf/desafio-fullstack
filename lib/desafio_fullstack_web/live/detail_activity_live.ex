defmodule DesafioFullstackWeb.DetailActivityLive do
  use Phoenix.LiveView

  alias DesafioFullstack.Activities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{activity: Activities.get_random()})}
  end

  def handle_event("back", _params, socket) do
    {:noreply, push_navigate(socket, to: "/")}
  end

  def render(assigns) do
    ~H"""
      <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
        }
        .container {
          max-width: 900px;  /* Largura máxima do conteúdo centralizado */
          margin: 0 auto;  /* Centraliza o conteúdo com espaços laterais iguais */
          padding: 0 20px; /* Adiciona padding lateral */
        }
        h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
            width: 100%;
        }
        .content {
            display: flex;
            justify-content: space-between;
            max-width: 800px;
            width: 100%;
        }
        .left-content {
            flex: 1;
            text-align: left;
            max-width: 45%; /* Limita a largura do conteúdo esquerdo */
        }
        .right-content {
            width: 50%;
            text-align: right;
            position: relative;
        }
        .header a {
            text-decoration: none;
            color: #007bff;
            font-size: 14px; /* Tamanho ajustado para coincidir com a descrição */
            font-weight: bold;
            display: inline-block;
            margin-bottom: 15px;
        }
        .place-title {
            font-size: 28px;
            font-weight: bold;
            margin-top: 10px;
            color: #111;
            text-align: left;
            margin-bottom: 0px; /* Diminui a margem entre o título e as tags */
        }

        .tags {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin: 5px 0; /* Reduz a margem entre as tags e o título */
        }

        .tag {
            background-color: #e1e1e1;
            color: #333;
            border-radius: 10px; /* Reduz o contorno mais arredondado */
            padding: 2px 6px;  /* Diminui o padding das tags */
            margin: 2px; /* Reduz o espaçamento entre as tags */
            font-size: 14px;
        }
        .description-label {
            font-weight: bold;
            font-size: 18px;
            margin-right: 10px;
        }
        .description {
            margin-top: 10px;
            font-size: 14px; /* Fonte reduzida */
            line-height: 1.5;
            color: #666;
            max-width: 100%; /* Garante que a descrição não ultrapasse sua caixa */
            overflow-wrap: break-word; /* Quebra o texto longo se necessário */
        }
        .buttons {
            margin-top: 20px;
            display: flex;
            justify-content: flex-start;
            gap: 10px;
        }
        .button {
            display: inline-flex;
            align-items: center;
            height: 30px; /* Altura fixa */
            padding: 3px 6px; /* Diminuído para metade da altura */
            line-height: 30px; /* Para centralizar o texto verticalmente */
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-size: 10px; /* Tamanho da fonte reduzido */
        }
        .button.instagram {
            margin-right: 5px;
            background-color: #e4405f;
        }
        .button .icon {
          margin-right: 5px;
          width: 20px;  /* Defina um tamanho específico */
          height: 20px; /* Ajuste conforme necessário */
          vertical-align: middle; /* Centraliza o ícone verticalmente */
        }
        .photos img {
            width: 100%;
            max-width: 400px;
            height: auto;
            border-radius: 10px;
            margin-top: 10px;
        }
        .description-and-photos {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-top: 10px;
        }
        .photos {
            text-align: left;
            margin-top: 0;
        }
        .photo-label {
            font-weight: bold;
            margin-bottom: 10px;
            text-align: left; /* Garante que o texto fique alinhado com a imagem */
        }
        .photo-label-container {
            display: flex;
            align-items: flex-start;
            margin-bottom: 10px;
        }
      </style>

      <body>
        <h1><strong>O que fazer em <span style="color: #007bff;">Maceió?</span></strong></h1>
        <div class="container">
          <div class="header">
            <a href="#" phx-click="back">← Voltar</a>
          </div>

          <div class="place-title"><%= @activity.title %></div>

          <div class="tags">
            <%= for tag <- @activity.tags do %>
              <div class="tag"><%= tag %></div>
            <% end %>
          </div>

          <div class="description-and-photos">
            <div class="left-content">
              <span class="description-label">Descrição</span>
              <div class="description">
                <%= @activity.description %>
              </div>

              <div class="buttons">
                <a href="#" class="button">
                  <Heroicons.map_pin solid class="icon" /> Google Maps
                </a>
                <a href="#" class="button instagram">
                  <Heroicons.camera solid class="icon" /> Instagram
                </a>
              </div>
            </div>

            <div class="right-content">
              <div class="photo-label-container">
                <div class="photo-label">Fotos</div>
              </div>
              <div class="photos">
                <img src="https://picsum.photos/536/700" alt="Imagem atividade">
              </div>
            </div>
          </div>
        </div>
      </body>
    """
  end
end
