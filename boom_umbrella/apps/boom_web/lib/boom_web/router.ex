defmodule BoomWeb.Router do
  use BoomWeb, :router

  if Mix.env() == :prod do
    use Plug.ErrorHandler
  end

  import Plug.BasicAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {BoomWeb.LayoutView, :root})
    plug(:protect_from_forgery)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :brute_force do
    plug(Auth.Plug.BruteForce, %{counts: 20, time_seconds: 60 * 2})
  end

  pipeline :auth do
    plug(Auth.Plug, roles: ["tenant"])
  end

  pipeline :is_auth do
    plug(Auth.Plug.IsAuth)
  end

  scope "/", BoomWeb do
    pipe_through(:browser)

    get("/frotend/*path", PageController, :index)
    # get("/uploads/:id", ImageController, :get_by_id)
  end

  pipeline(:admin_devoloper) do
    plug(:basic_auth,
      username: "admin_developer",
      password: Boom.Helper.get_dashboard_auth()
    )
  end

  # Other scopes may use custom stacks.

  scope "/api/:version/", BoomWeb do
    pipe_through([:api])

    scope "/views" do
      get("/all", ViewsController, :get_all)
      get("/attrs", ViewsController, :get_by_attrs)
      get("/:id", ViewsController, :get)
    end

    # @generate
    scope "/location" do
      get("/", LocationController, :get_by_sample)
    end

    scope "/auth" do
      pipe_through(:brute_force)
      post("/register", UserController, :register)
      post("/login", UserController, :login)

      get("/confirm", ConfirmController, :get)
      post("/restore", ConfirmController, :restore)
      get("/confirm/:id/:number", ConfirmController, :confirm_email)
      get("/restore_password/:id/:number", ConfirmController, :link_accept_restore)
      post("/restore_password", ConfirmController, :restore_password)
      post("/request_restore_password", ConfirmController, :request_restore_password)

      pipe_through(:auth)
      get("/me", UserController, :auth_me)
    end

    scope "/user" do
      get("/:id", UserController, :get_by_id)
      get("/profile/:login", UserController, :get_profile)
      get("/search_by_login/:login", UserController, :search_by_login)
    end

    scope "/like" do
      get("/", LikeController, :get_like_by_id)
    end

    pipe_through(:auth)

    scope "/like" do
      get("/info", LikeController, :info)

      post("/", LikeController, :like)
    end

    # @generate

    scope "/money" do
      scope "movement" do
        post("/", MoneyMovementController, :create)
        get("/all", MoneyMovementController, :get_all)
        get("/attrs", MoneyMovementController, :get_by_attrs)
        get("/:id", MoneyMovementController, :get)
        put("/", MoneyMovementController, :update)
        delete("/:id", MoneyMovementController, :delete)
      end

      post("/", MoneyController, :create)
      get("/all", MoneyController, :get_all)
      get("/attrs", MoneyController, :get_by_attrs)
      get("/:id", MoneyController, :get)
      put("/", MoneyController, :update)
      delete("/:id", MoneyController, :delete)
    end

    scope "/location" do
      get("/", LocationController, :get_by_sample)
    end

    scope "/incident" do
      post("/", IncidentController, :create)
      get("/all", IncidentController, :get_all)
      get("/attrs", IncidentController, :get_by_attrs)
      get("/:id", IncidentController, :get)
      put("/", IncidentController, :update)
      put("/", IncidentController, :update_from_manager)
      put("/", IncidentController, :update_from_org)
      delete("/:id", IncidentController, :delete)
    end

    scope "/organization" do
      post("/", OrganizationController, :create)
      get("/all", OrganizationController, :get_all)
      get("/attrs", OrganizationController, :get_by_attrs)
      get("/:id", OrganizationController, :get)
      put("/", OrganizationController, :update)
      delete("/:id", OrganizationController, :delete)
    end

    scope "/post" do
      post("/", PostController, :create)
      get("/all", PostController, :get_all)
      get("/attrs", PostController, :get_by_attrs)
      get("/:id", PostController, :get)
      put("/", PostController, :update)
      delete("/:id", PostController, :delete)
    end

    scope "/comments" do
      post("/", CommentsController, :create)
      get("/all", CommentsController, :get_all)
      get("/attrs", CommentsController, :get_by_attrs)
      get("/:id", CommentsController, :get)
      put("/", CommentsController, :update)
      delete("/:id", CommentsController, :delete)
    end

    scope "/user/" do
      post("/profile_edit", UserController, :profile_edit)
    end

    scope "/image/" do
      get("/get_all", ImageController, :all)
      get("/random", ImageController, :random)
    end

    post("/upload_img", ImageController, :create)
  end

  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through([:browser, :admin_devoloper])

    live_dashboard("/dashboard", metrics: BoomWeb.Telemetry)
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through(:browser)

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
