PROTOC := protoc

PROTO_DIR := ./plugin
PROTO_FILES := $(wildcard $(PROTO_DIR)/*.proto)

GO_OUT_DIR := ./gen/go
CSHARP_OUT_DIR := ./gen/csharp

GRPC_PLUGIN = C:\Users\SydneyOwl\.nuget\packages\grpc.tools\2.78.0\tools\windows_x64\grpc_csharp_plugin.exe

.PHONY: all clean dep proto-go proto-cs proto help

all: dep proto

dep:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

proto-go:
	@echo "Generating Go code..."
	$(PROTOC) --proto_path=$(PROTO_DIR) \
		--proto_path=. \
		--go_out=$(GO_OUT_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(GO_OUT_DIR) \
		--go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)

proto-cs:
	@echo "Generating C# code..."
	$(PROTOC) --proto_path=$(PROTO_DIR) \
		--proto_path=. \
		--csharp_out=$(CSHARP_OUT_DIR) \
		--grpc_out=$(CSHARP_OUT_DIR) \
		--plugin=protoc-gen-grpc=$(GRPC_PLUGIN) \
		$(PROTO_FILES)

proto: proto-go proto-cs

clean:
	rm -rf ./gen

help:
	@echo "Available targets:"
	@echo "  all      - Install dependencies and generate all code"
	@echo "  dep      - Install protoc plugins"
	@echo "  proto    - Generate Go and C# code"
	@echo "  proto-go - Generate Go code only"
	@echo "  proto-cs - Generate C# code only"
	@echo "  clean    - Clean generated files"
	@echo "  help     - Show this help"