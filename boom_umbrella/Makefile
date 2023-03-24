export DATABASE_URL=postgresql://postgres:postgres@localhost/boom_dev
export SECRET_KEY_BASE=postgres
export AUTH_PASSWORD=1234
export SMTP_USERNAME=postgres
export SMTP_PASSWORD=1234

install: 
	mix.bat deps.get
	mix.bat deps.compile
phx: 
	iex.bat -S mix phx.serve
	

migrate_auth:
	cd "./apps/auth" && mix ecto.migrate

rollback_auth:
	cd "./apps/auth" && mix ecto.rollback --step 30

rollback_nv:
	cd "./apps/boom" && mix ecto.rollback --step 30

migrate_nv:
	cd "./apps/boom" && mix ecto.migrate

reset_nv:
	cd "./apps/boom" && mix ecto.rollback --step 30 && mix ecto.migrate

get_collection:
	mix ms.gen.collection

build_for_production:
	MIX_ENV=prod 
	mix do deps.get --only MIX_ENV=prod, deps.compile
	MIX_ENV=prod mix compile
	MIX_ENV=prod mix release
	MIX_ENV=prod mix phx.digest

start_for_production:
	_build/prod/rel/boom_umbrella/bin/boom_umbrella start


remote_for_proudction:
	_build/prod/rel/boom_umbrella/bin/boom_umbrella/bin/

start_production: 
	PORT=4000 MIX_ENV=prod mix phx.server