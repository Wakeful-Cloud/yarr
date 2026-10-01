package server

import (
	"net/http"

	"github.com/nkanaev/yarr/src/storage"
)

type StorageProvider interface {
	GetStorage(r *http.Request) storage.Storage
}

type localStorage struct {
	storage storage.Storage
}

func NewLocalStorage(db storage.Storage) StorageProvider {
	return &localStorage{storage: db}
}

func (s *localStorage) GetStorage(r *http.Request) storage.Storage {
	return s.storage
}
