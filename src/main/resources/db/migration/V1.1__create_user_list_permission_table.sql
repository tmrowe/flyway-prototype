CREATE TABLE user_list_permission (
    user_uuid UUID REFERENCES "user"(uuid) NOT NULL,
    list_uuid UUID REFERENCES list(uuid) NOT NULL,
    can_view BOOLEAN DEFAULT FALSE,
    can_edit BOOLEAN DEFAULT FALSE,
    can_delete BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
