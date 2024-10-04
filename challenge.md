# Desafio Técnico

## Descrição

Este desafio consiste em desenvolver uma aplicação web para ajudar usuários a encontrar atividades e lugares interessantes em uma cidade específica.
A ideia é permitir que os usuários descubram atividades de forma aleatória e também tenham a opção de buscar por atividades específicas que desejam realizar.

Você irá trabalhar em uma aplicação Phoenix, que já está configurada, e sua tarefa será implementar as funcionalidades descritas abaixo utilizando, Phoenix, Liveview, Ecto e PostgreSQL.

## Funcionalidades

Importante: O candidato não precisa implementar todas as funcionalidades listadas abaixo. Nenhum item é desclassificatório. Faça o que for possível dentro do seu tempo e habilidades.

1. **Modelagem de Dados:**
   - Crie um modelo de dados para armazenar informações sobre atividades. Cada atividade deve ter um título, descrição, Instagram, local no Google Maps, e tags (como "esportes", "museus", "parques", "gratuito", "bom para crianças", "bom para casais", etc).

2. **Script de Seed:**
   - Crie um script de seed para popular o banco de dados com **100 atividades** fictícias.

3. **Atividade Surpresa:**
   - Na página principal, deve haver uma seção onde os usuários possam ver uma "atividade surpresa". Esta atividade deve ser selecionada aleatoriamente a partir de uma lista de atividades cadastradas no sistema.
   - O usuário deve poder solicitar uma "outra sugestão", que exibirá uma nova atividade aleatória sem recarregar a página.
   - Tela: [/challenge/home.png](./challenge/home.png)

4. **Busca de Atividades:**
   - Os usuários devem poder buscar por atividades específicas utilizando uma campo de pesquisa.
   - A listagem de atividades deve ser filtrável por tags, permitindo que os usuários explorem atividades que sejam de seu interesse.
   - Ao clicar em uma tag, seja no card de uma atividade ou até na página de detalhes de uma atividade, o usuário deve ser direcionado para uma página de busca com todas as atividades que possuem aquela tag.
   - Ao buscar ou filtrar algo, manter o estado na URL, permitindo que os usuários compartilhem links para buscas específicas.
   - Telas: [/challenge/selecao-filtro.png](./challenge/selecao-filtro.png), [./challenge/filtro.png](./challenge/filtro.png), [/challenge/busca-e-filtro.png](./challenge/busca-e-filtro.png)

5. **Detalhes da Atividade:**
   - Ao clicar em uma atividade, o usuário deve ser direcionado para uma página de detalhes, onde poderá ver informações mais detalhadas sobre a atividade.
   - Tela: [/challenge/detalhes-atividade.png](./challenge/detalhes-atividade.png)

## Dicas e diferenciais
- Você pode utilizar a biblioteca [Faker](https://github.com/elixirs/faker) para gerar dados do script de seed.
- Você pode utilizar o serviço [Lorem Picsum](https://picsum.photos/) para imagens aleatórias nas atividades.
- Todos os ícones utilizados foram da biblioteca [Heroicons](https://heroicons.com/), que já está configurada no projeto. A única exceção é o ícone do Instagram, que está disponível em `priv/statis/icons/instagram.svg`.
- Se necessário, você pode utilizar JavaScript para implementar funcionalidades específicas, ou até Alpine.js, se preferir.
- Testes automatizados são sempre muito bem-vindos.
- Atenção aos detalhes de UI/UX e acessibilidade são diferenciais importantes.
