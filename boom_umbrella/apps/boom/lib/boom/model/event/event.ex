defmodule Boom.Model.Event do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "event" do
    field(:arr_events, {:array, :map})
    field(:slide_id, :binary_id)
    field(:name, :string)
    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:arr_events, :slide_id, :name])
    |> validate_required([:arr_events, :slide_id, :name])
  end
end
