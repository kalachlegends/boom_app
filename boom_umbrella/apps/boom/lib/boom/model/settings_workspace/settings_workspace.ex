defmodule Boom.Model.SettingsWorkspace do
  use Ecto.Schema
  import Ecto.Changeset

  schema "settings_novella" do
    field(:height, :integer)
    field(:width, :integer)
    field(:novella_id, :binary_id)

    field(:font_size, :integer)
    field(:font_family, :string)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(novella_id)a
  @optional_fields ~w(height width novella_id font_family font_size)a
  @doc false
  def changeset(settings_novella, attrs) do
    settings_novella
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@optional_fields)
  end
end
