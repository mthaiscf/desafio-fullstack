# Desafio Full Stack
Todos os detalhes do desafio estão descritos no arquivo [`challenge.md`](./challenge.md).

## Tecnologias utilizadas
- [Elixir](https://elixir-lang.org/)
- [Phoenix Framework](https://www.phoenixframework.org/)
- [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)
- [Ecto](https://hexdocs.pm/ecto/Ecto.html)
- [PostgreSQL](https://www.postgresql.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Heroicons](https://heroicons.com/)
- [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/)

## Setup recomendado para rodar a aplicação
- [asdf](https://asdf-vm.com/) para o gerenciamento de versões do Elixir e Erlang.
  - Os plugins https://github.com/asdf-vm/asdf-elixir e https://github.com/asdf-vm/asdf-erlang são necessários.
  - o projeto conta com o arquivo `.tool-versions` que já possui as versões recomendadas para o Elixir e Erlang. Basta rodar `asdf install` na raiz do projeto.
- [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/) para rodar o banco de dados PostgreSQL.
  - O projeto já conta com o arquivo `docker-compose.yml` para subir o banco de dados. Basta rodar `docker-compose up -d` na raiz do projeto.

## Rodando a aplicação
- Inicialize o banco de dados com `docker-compose up -d`.
- Faça o download das dependencias, crie o banco de dados e rode as migrations com o comando `mix setup`.
- Inicie o servidor Phoenix com `mix phx.server`.

Agora você pode acessar [`localhost:4000`](http://localhost:4000) do seu navegador.

## Rodando os testes
- Inicialize o banco de dados com `docker-compose up -d`.
- Faça o download das dependencias, crie o banco de dados e rode as migrations com o comando `mix setup`.
- Rode os testes com o comando `mix test`.
- Para verificar a cobertura de testes, rode `mix test --cover`.
