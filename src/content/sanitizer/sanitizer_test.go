package sanitizer

import (
	"os"
	"path/filepath"
	"strings"
	"testing"
)

const baseURL = "http://example.org/"

func readFixture(t *testing.T, path string) string {
	t.Helper()
	data, err := os.ReadFile(path)
	if err != nil {
		t.Fatalf("unable to read fixture %q: %v", path, err)
	}
	return strings.TrimSuffix(string(data), "\n")
}

func TestSanitizeTestData(t *testing.T) {
	files, err := filepath.Glob("testdata/*.in.html")
	if err != nil {
		t.Fatal(err)
	}

	for _, file := range files {
		name := strings.TrimSuffix(filepath.Base(file), ".in.html")
		t.Run(name, func(t *testing.T) {
			raw := readFixture(t, file)
			want := readFixture(t, filepath.Join("testdata", name+".out.html"))
			have := Sanitize(baseURL, raw)

			if want != have {
				t.Errorf("Wrong output:\nwant: %s\nhave: %s", want, have)
			}
		})
	}
}
