To build this image, first build the tier/base image, available
from https://github.com/scottylogan/tier-base.git, then run `make`
to build a grouper image.

To customize the image at run-time, mount a volume on `/etc/tier`; the
volume should include a file named `common.yaml`, similar to this:

    ---
    grouper::db_class: com.mysql.jdbc.Driver
    grouper::db_dialect: org.hibernate.dialect.MySQL5Dialect
    grouper::db_host: tierdb
    grouper::db_name: grouper
    grouper::db_pass: ChangeMe!
    grouper::db_port: 3306
    grouper::db_type: mysql
    grouper::db_user: grouper
    grouper::java_home: /usr/lib/jvm/java
    shibsp::contact: "support@localhost"
    shibsp::entity_id: "https://localhost"
    shibsp::idp_entity_id: "https://idp.example.edu/"
    shibsp::idp_metadata_url: "https://idp.example.edu/metadata.xml"

Next, run `/usr/local/bin/tierconfig`.


Alternatively, put your `common.yaml` file in a directory with this
Dockerfile:

    FROM tier/grouper
    MAINTAINER Alice Groupmeister <alice@example.edu>

    COPY common.yaml /etc/tier/
    RUN /usr/local/bin/tierconfig

Then run this command in the same directory:

    docker build -t example/grouper .

