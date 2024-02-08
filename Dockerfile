FROM sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1 AS scala-build
WORKDIR /lila
COPY lila .
COPY application.conf /lila/conf/application.conf
RUN ./lila clean compile

FROM node:21 AS ui-build
WORKDIR /lila
COPY --from=scala-build /lila .
RUN npm i -g pnpm && \
    ./ui/build

# FROM eclipse-temurin:21.0.2_13-jdk-jammy
FROM sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1
WORKDIR /lila
COPY --from=ui-build /lila .
CMD ["./lila", "run"]
