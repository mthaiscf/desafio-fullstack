defmodule DesafioFullstackWeb.DesafioFullstackWeb.SearchActivitiesLive do

  use Phoenix.LiveView

  alias DesafioFullstack.Activities



  def mount(_session, socket) do
    {:ok, assign(socket, %{activities_list: Activities.get_by_city("Maceió"), activity: Activities.get_random()})}
  end

  def handle_event("search_activities", %{"title" => title, "tags" => tags}, socket) do
    activities_list = Activities.get_by_title_and_tags(title, tags)
    {:noreply, assign(socket, activities_list: activities_list)}
  end

  def handle_event("get_surprise_activity", _params, socket) do
    activity = Activities.get_random()
    {:noreply, assign(socket, activity: activity)}
  end

  def handle_event("start", _params, socket) do
    activities_list = Activities.get_by_city("Maceió")
    activity = Activities.get_random()
    {:noreply, assign(socket, activities_list: activities_list, activity: activity)}
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
            max-width: 536px; /* Largura das imagens */
            padding: 0 10px;
        }
        .image-container {
            position: relative; /* Permite o posicionamento absoluto dos elementos filhos */
            max-width: 536px;
            margin-bottom: 20px;
            text-align: left; /* Alinha texto à esquerda */
        }
        img {
            max-width: 100%; /* Para que a imagem não extrapole o container */
            height: auto;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 10px; /* Espaçamento entre a imagem e o input */
        }
        .tag {
            position: absolute; /* Para posicionar o texto sobre a imagem */
            bottom: 10px; /* Distância do fundo */
            left: 20px; /* Distância do lado esquerdo */
            background-color: rgba(255, 255, 255, 0.8); /* Fundo semi-transparente */
            padding: 2px 5px; /* Espaçamento interno */
            border-radius: 3px; /* Bordas arredondadas */
            font-size: 0.9rem; /* Tamanho da fonte */
            color: #333; /* Cor do texto */
            bottom: 30px;
        }
        .title {
            position: absolute; /* Para posicionar o título sobre a imagem */
            bottom: 60px; /* Distância acima da tag */
            left: 20px; /* Distância do lado esquerdo */
            padding: 2px 5px; /* Espaçamento interno */
            border-radius: 2px; /* Bordas arredondadas */
            font-size: 1.2rem; /* Tamanho da fonte */
            color: rgba(255, 255, 255, 0.8); /* Cor do texto */
        }
        input {
            padding: 10px;
            font-size: 1rem;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 536px; /* Largura igual à das imagens */
            margin-left: 20px; /* Alinhamento à esquerda */
        }
        .result {
            margin-top: 10px;
            font-size: 1.2rem;
            color: #333;
        }
        .link-right {
            font-size: 1rem; /* Ajuste para manter uniformidade */
            color: #1E90FF;
            text-decoration: none;
            margin-left: 10px; /* Espaço entre o título e o link */
            display: flex;
            align-items: center; /* Alinha verticalmente com o ícone */
        }
        .icon {
            width: 20px; /* Tamanho reduzido do ícone */
            height: 20px; /* Tamanho reduzido do ícone */
            margin-right: 8px; /* Espaço entre o ícone e o texto */
            display: inline-block; /* Garante o alinhamento do ícone com o texto */
        }
        .section-title div {
            display: flex;
            align-items: center; /* Alinha o ícone e o texto no centro */
        }
        .co-working {
            font-size: 0.9rem; /* Tamanho da fonte para a tag co-working */
            color: black; /* Cor do texto preta */
            margin-top: 5px; /* Espaço acima da tag para alinhamento */
            background-color: #d3d3d3; /* Fundo cinza */
            padding: 2px 5px; /* Espaçamento interno */
            border-radius: 3px; /* Bordas arredondadas */
            display: inline-block; /* Para que a tag tenha um espaço em volta */
            position: relative; /* Para o posicionamento do 'x' */
            margin-left: 20px; /* Alinhamento à esquerda igual ao input */
        }
        .remove-tag {
            margin-left: 5px; /* Espaço à esquerda do 'x' */
            cursor: pointer; /* Muda o cursor para indicar que é clicável */
            font-weight: bold; /* Negrito para o 'x' */
            color: black; /* Cor do 'x' igual à da tag */
        }
        .activity-count {
            font-size: 1rem; /* Tamanho da fonte para a contagem de atividades */
            color: #333; /* Cor do texto */
            margin-top: 5px; /* Espaço acima do texto */
            text-align: left; /* Alinhado à esquerda */
            margin-left: 20px; /* Para manter o mesmo alinhamento que as imagens */
        }
    </style>


    <script>
        function removeTag() {
            const tag = document.getElementById('co-working-tag');
            if (tag) {
                tag.style.display = 'none'; // Esconde a tag ao clicar no 'x'
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

    <div class="image-container">
        <img src="https://picsum.photos/536/354" alt="Imagem de Maceió">
        <div class="title"><strong>Ativ1</strong></div>
        <div class="tag">Gratuito</div>
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

    <div class="co-working" id="co-working-tag">
        Co-working
        <span class="remove-tag" onclick="removeTag()">×</span> <!-- 'x' para remover -->
    </div>


    """
  end

end
