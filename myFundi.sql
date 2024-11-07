CREATE TABLE "technicians" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "full_name" varchar NOT NULL,
  "hashed_password" varchar NOT NULL,
  "picture" varchar,
  "phone_number" bigint NOT NULL,
  "email" varchar NOT NULL,
  "location" varchar NOT NULL,
  "skill" varchar NOT NULL,
  "experience" int NOT NULL,
  "certification" varchar,
  "hourly_rating" bigint NOT NULL,
  "availability" int NOT NULL,
  "bio" text,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "full_name" varchar NOT NULL,
  "hashed_password" varchar NOT NULL,
  "email" varchar NOT NULL,
  "phone_number" bigint NOT NULL,
  "location" varchar NOT NULL,
  "preferences" varchar NOT NULL,
  "service_history" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "services" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "technician_id" int NOT NULL,
  "type" varchar NOT NULL,
  "description" varchar NOT NULL,
  "pricing" bigint NOT NULL,
  "time_estimate" int NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "bookings" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" int NOT NULL,
  "technician_id" int NOT NULL,
  "service_id" int NOT NULL,
  "scheduled_date" date NOT NULL,
  "status" varchar NOT NULL,
  "total_cost" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "reviews" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "technician_id" int NOT NULL,
  "user_id" int NOT NULL,
  "rating" int NOT NULL,
  "comments" text NOT NULL,
  "date" date NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "notifications" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "technician_id" int NOT NULL,
  "user_id" int NOT NULL,
  "message_contents" text NOT NULL,
  "sent_at" timestamptz NOT NULL DEFAULT (now()),
  "read_status" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "messages" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "sender_id" int NOT NULL,
  "receiver_id" int NOT NULL,
  "content" text NOT NULL,
  "sent_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "services" ("technician_id");

CREATE INDEX ON "bookings" ("user_id");

CREATE INDEX ON "bookings" ("technician_id");

CREATE INDEX ON "bookings" ("service_id");

CREATE INDEX ON "bookings" ("user_id", "technician_id", "service_id");

CREATE INDEX ON "reviews" ("technician_id");

CREATE INDEX ON "reviews" ("user_id");

CREATE INDEX ON "reviews" ("technician_id", "user_id");

CREATE INDEX ON "notifications" ("technician_id");

CREATE INDEX ON "notifications" ("user_id");

CREATE INDEX ON "notifications" ("technician_id", "user_id");

CREATE INDEX ON "messages" ("sender_id");

CREATE INDEX ON "messages" ("receiver_id");

CREATE INDEX ON "messages" ("sender_id", "receiver_id");

ALTER TABLE "services" ADD FOREIGN KEY ("technician_id") REFERENCES "technicians" ("id");

ALTER TABLE "bookings" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "bookings" ADD FOREIGN KEY ("technician_id") REFERENCES "technicians" ("id");

ALTER TABLE "bookings" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("technician_id") REFERENCES "technicians" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "notifications" ADD FOREIGN KEY ("technician_id") REFERENCES "technicians" ("id");

ALTER TABLE "notifications" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("sender_id") REFERENCES "users" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("sender_id") REFERENCES "technicians" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("receiver_id") REFERENCES "users" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("receiver_id") REFERENCES "technicians" ("id");
