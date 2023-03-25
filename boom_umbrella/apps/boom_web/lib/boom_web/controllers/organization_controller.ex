defmodule BoomWeb.OrganizationController do
  @moduledoc """
  # Create organization -> CRUD
  """
  @body %{
    user_id: "",
    locations_list: [],
    title: ""
  }

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.Organization
  alias Boom.Service.Organization, as: OrganizationService
  alias Boom.Helper

  @doc """
  # Create organization
  """
  @doc body: @body
  @doc auth: "token"
  def create(conn, params) do
    user_opts = %{
      email: "",
      passord: params["password"],
      repassword: params["password"],
      login: params["bin"],
      data: "",
      roles: params["roles"]
    }

    with {:ok, user, token} <- Auth.Service.User.register(user_opts),
         {:ok, item} <-
           Organization.create(
             user_id: user.id,
             locations_list: params["locations_list"],
             title: params["title"]
           ) do
      {:render, %{organization: item}}
    end
  end

  @doc """
  # Update organization
  """
  @doc body: @body
  @doc auth: "token"
  def update(conn, params) do
    with {:ok, item} <-
           Organization.update_by_id(params["id"], params) do
      {:render, %{organization: item}}
    end
  end

  @doc """
  # Get by attrs organization
  """
  @doc params: @body
  @doc auth: "token"
  def get_by_attrs(conn, params) do
    with {:ok, item} <- Organization.get(params) do
      {:render, %{organization: item}}
    end
  end

  @doc """
  # Get_all by attrs organization
  """
  @doc params: @body
  @doc auth: "token"
  def get_all(conn, params) do
    with {:ok, item} <- Organization.get_all(params) do
      {:render, %{organization: item}}
    end
  end

  @doc """
  # Get organization
  """
  @doc auth: "token"
  def get(conn, params) do
    with {:ok, item} <- Organization.get(params["id"]) do
      {:render, %{organization: item}}
    end
  end

  @doc """
  # Delete organization
  """
  @doc auth: "token"
  def delete(conn, params) do
    with {:ok, item} <- Organization.delete(params["id"]) do
      {:render, %{organization: item}}
    end
  end
end
