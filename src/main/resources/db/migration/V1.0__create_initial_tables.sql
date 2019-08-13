CREATE TABLE "user" (
    uuid UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE list (
    uuid UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    created_by UUID REFERENCES "user"(uuid),
    name VARCHAR(256),
    description VARCHAR(256),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
