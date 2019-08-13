CREATE TABLE user_list_permission (
    user_uuid UUID NOT NULL REFERENCES "user"(uuid),
    list_uuid UUID NOT NULL REFERENCES list(uuid),
    can_view BOOLEAN NOT NULL DEFAULT FALSE,
    can_edit BOOLEAN NOT NULL DEFAULT FALSE,
    can_delete BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
