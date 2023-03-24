defmodule Boom.Model.Slide do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "slide" do
    field(:tree_id, :binary_id)
    field(:workspace, :string, default: "")
    field(:type_delete, SlideType, default: "not_delete")
    field(:sort_number, :integer, default: 0)
    # field(:max_balls, :integer)
    field(:name, :string, default: "Slide 0")
    field(:type, NovellaType, default: :visual)
    field(:user_id, :binary_id)

    field(:workspace_json, :map,
      default: %{
        elements: [],
        settings_workspace: %{}
      }
    )

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo

  @required_fields ~w(tree_id)a
  @optional_fields ~w(workspace user_id type type_delete sort_number name workspace_json)a
  @doc false
  def changeset(slide, attrs) do
    slide
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
