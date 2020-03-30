# curl

## GET

### json

```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://hostname/resource
```

### xml

```bash
curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET http://hostname/resource
```

## POST

### For posting data

```bash
curl --data "param1=value1&param2=value2" http://hostname/resource
```

### For file upload

```bash
curl --form "fileupload=@filename.txt" http://hostname/resource
```

### RESTful HTTP Post

```bash
curl -X POST -d @filename http://hostname/resource
```

### For logging into a site (auth)

```bash
curl -d "username=admin&password=admin&submit=Login" --dump-header headers http://localhost/Login
curl -L -b headers http://localhost/

```

## References

- <https://askubuntu.com/a/379218>
