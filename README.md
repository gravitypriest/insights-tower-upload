# insights-tower-upload
Simple script to upload an archive to Red Hat Insights with basic auth.

### Usage:
```
$ insights-tower-upload.sh -u USERNAME -p PASSWORD -f FILE -c CONTENT-TYPE
```
- `-u USERNAME` - where `USERNAME` is your Red Hat Customer Portal username
- `-p PASSWORD` - where `PASSWORD` is your Red Hat Customer Portal password
  - This is optional and may be specified at the `curl` interactive prompt instead.
- `-f FILE` - where `FILE` is a file to be uploaded
- `-c CONTENT-TYPE` - where `CONTENT-TYPE` is the Insights-tangential content-type of `FILE`
  - This is optional and a default content-type will be selected if unspecified.
- `-v` - Print verbose `curl` output
- `-h` - Print help
