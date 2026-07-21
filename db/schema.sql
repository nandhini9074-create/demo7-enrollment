CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id VARCHAR UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE user_cards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    card_id VARCHAR(100) NOT NULL,
    scheme_card_id VARCHAR(100),
    card_scheme VARCHAR(20) NOT NULL,
    card_bin VARCHAR(12),
    card_last4 VARCHAR(4) NOT NULL,
    scheme_user_id VARCHAR(100),
    finger_print VARCHAR(50) UNIQUE,
    issuer_bank VARCHAR(100),
    is_active BOOLEAN NOT NULL,
    profile_id UUID,
    parent_card_id VARCHAR,
    is_supplementary BOOLEAN NOT NULL DEFAULT FALSE,
    status VARCHAR(7) NOT NULL DEFAULT 'ACTIVE',
    activity VARCHAR,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (user_id) REFERENCES customers (id),
    CONSTRAINT user_cards_user_id_scheme_card_id_idx UNIQUE (user_id, scheme_card_id)
);

CREATE TABLE activity_logs (
    id SERIAL PRIMARY KEY,
    trace_id UUID NOT NULL,
    step VARCHAR NOT NULL,
    request_data JSONB,
    response_data JSONB,
    error JSONB,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);