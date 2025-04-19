DC := docker-compose
SERVICE := rustlings
CONTAINER := rustlings-app
WORKDIR := /app

# 🔧 建置容器
build:
	@echo "🔧 Building Docker image..."
	$(DC) build

# 🧪 啟動短命容器（有 oh-my-zsh 的 login shell）
run:
	@echo "🧪 Running temporary zsh container..."
	$(DC) run --rm --workdir $(WORKDIR) $(SERVICE) zsh -l

# 🧼 停止背景容器
down:
	@echo "🧼 Stopping container..."
	$(DC) down

# 🧼 Reset 一切（包含 volumes）
reset:
	@echo "🧼 Resetting full environment (with volumes)..."
	$(DC) down -v --remove-orphans

# 🏗 啟動背景容器
up:
	@echo "🏗 Starting container..."
	$(DC) up -d

# 🐚 進入正在執行的容器
sh:
	@echo "🐚 Attaching to running container..."
	docker exec -it $(CONTAINER) zsh -l

# 🧘‍♂️ 執行 rustlings watch（於正確專案路徑）
watch:
	@echo "🧘‍♂️ Starting rustlings watch in /app..."
	$(DC) run --rm --workdir $(WORKDIR) $(SERVICE) zsh -l -c "rustlings"

# 🚀 開發模式：啟動並進入容器
dev:
	@echo "🚀 Starting dev container..."
	-$(DC) up -d
	docker exec -it $(CONTAINER) zsh -l