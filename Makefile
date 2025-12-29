dep:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

proto-go:
	rm -f *.go && protoc --go_out=. --go_opt=paths=source_relative *.proto

proto-cs:
	rm -f *.cs && protoc --csharp_out=. *.proto