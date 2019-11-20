FROM oracle/graalvm-ce:19.2.1 as graalvm
COPY . /home/app/micronaut-nat-image-app
WORKDIR /home/app/micronaut-nat-image-app
RUN gu install native-image
RUN native-image --no-server -cp target/micronaut-nat-image-app-*.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/micronaut-nat-image-app .
ENTRYPOINT ["./micronaut-nat-image-app"]
