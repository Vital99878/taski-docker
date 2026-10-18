# Makefile для проекта Taski

# Имена образов
FRONTEND_IMAGE = taski-frontend
BACKEND_IMAGE  = taski-backend

# Имена контейнеров
FRONTEND_CONTAINER = taski-frontend
BACKEND_CONTAINER  = taski-backend

.PHONY: build run all clean

# Сборка обоих образов
build:
	cd frontend && docker build -t $(FRONTEND_IMAGE) .
	cd backend  && docker build -t $(BACKEND_IMAGE) .

# Запуск контейнеров (с предварительным удалением старых, если есть)
run:
	-docker rm -f $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER)
	docker run --name $(FRONTEND_CONTAINER) -d -p 3000:3000 $(FRONTEND_IMAGE)
	docker run --name $(BACKEND_CONTAINER)  -d -p 8000:8000 $(BACKEND_IMAGE)

# Полная сборка и запуск
all: build run

# Очистка: остановить и удалить контейнеры и образы
clean:
	-docker stop $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER)
	-docker rm   $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER)
	-docker rmi  $(FRONTEND_IMAGE) $(BACKEND_IMAGE)