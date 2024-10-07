defmodule DesafioFullstack.Repo.Migrations.CreateTableActivities do
  use Ecto.Migration

  def change do
    create table(:activities,
             primary_key: false,
             comment:
               "Tabela que armazena atividades para serem feitas em uma determinada cidade"
           ) do
      add :id, :uuid, primary_key: true, null: false

      add :title, :string, null: false, comment: "Título da atividade"
      add :photo, :string, null: false, comment: "Referência de armazenamento da foto da atividade"
      add :description, :string, null: false, comment: "Descrição da atividade"
      add :instagram_account, :string, null: true, comment: "Conta de Instagram da atividade"
      add :google_place, :string, null: false, comment: "Referência do Google da atividade"
      add :url, :string, null: true, comment: "Endereço Web da atividade"
      add :address, :string, null: false, comment: "Endereço da atividade"
      add :address_complement, :string, null: true, comment: "Complemento do endereço da atividade"
      add :email, :string, null: true, comment: "E-mail de contato da atividade"
      add :phone_number, :string, null: true, comment: "Número de telefone de contato para informações sobre a atividade"
      add :city, :string, null: false, comment: "Cidade onde a atividade reside"
      add :tags, :map, null: false, comment: "Tags que classificam a atividade"

      timestamps()
    end
  end
end
