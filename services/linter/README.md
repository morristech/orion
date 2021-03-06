# Linter

Common linters Dockerized for easier usage in CI

```
docker pull mozillasecurity/linter
```

## Dockerfiles

### Hadolint

#### Single
```bash
docker run --rm -v $(PWD):/mnt mozillasecurity/linter hadolint <Dockerfile>
```

#### Batch
```bash
find . -type f -name "Dockerfile" | xargs \
    docker run --run -v $(PWD):/mnt mozillasecurity/linter hadolint \
        --ignore DLXXXX \
        <...>
```

## Shellscripts

### Shellcheck

#### Single
```bash
docker run --rm -v $(PWD):/mnt mozillasecurity/linter shellcheck -x -Calways <shellscript>
```

#### Batch
```bash
find . -type f \( -iname "*.bash" -o -iname "*.sh" \) | xargs \
    docker run --rm -v $(PWD):/mnt mozillasecurity/linter shellcheck -x -Calways
```

In case there are bash scripts like 'hooks' without file-type extension while ignoring all scripts which are in hidden directories.

```bash
find . \
    -not -path '*/\.*' \
    -exec sh -c '[ $(file -b --mime-type {}) == "text/x-shellscript" ]' sh '{}' ';' \
    -print | xargs \
        docker run --rm -v $(PWD):/mnt mozillasecurity/linter shellcheck -x -Calways
```
