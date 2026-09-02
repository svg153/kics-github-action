FROM docker.io/checkmarx/kics:v2.1.19@sha256:7b0a4d750acd491942ce9de52c1183fbf4451c1c936780ec2cfacd2650e7d84c AS kics-env

# Updated 2026-09-02: previous pinned digest (sha256:70750dfd... from Apr 2026)
# ships glibc < 2.44, while nodejs-26 installed at runtime by entrypoint.sh
# requires GLIBC_2.44, making node crash after the scan.
# See https://github.com/Checkmarx/kics-github-action/issues/160
FROM cgr.dev/chainguard/wolfi-base:latest@sha256:1cec89e6c040d7a1ff412318d7a5fa89bab2c8b56e44d0a30f1df8acd646e1d0
 
COPY --from=kics-env /app /app
 
COPY ./entrypoint.sh /entrypoint.sh
 
RUN chmod +x /entrypoint.sh
 
COPY ./ /app
 
ENTRYPOINT ["/entrypoint.sh"]
