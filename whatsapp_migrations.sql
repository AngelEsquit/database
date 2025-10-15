-- WhatsApp configuration table
CREATE TABLE IF NOT EXISTS whatsapp_config (
    id SERIAL PRIMARY KEY,
    phone_number_id VARCHAR(255) NOT NULL,
    access_token TEXT NOT NULL,
    business_account_id VARCHAR(255) NOT NULL,
    webhook_verify_token VARCHAR(255),
    is_active BOOLEAN DEFAULT false,
    reminder_enabled BOOLEAN DEFAULT false,
    reminder_3_days_before BOOLEAN DEFAULT true,
    reminder_1_day_before BOOLEAN DEFAULT true,
    reminder_2_hours_before BOOLEAN DEFAULT false,
    template_name_reminder VARCHAR(255) DEFAULT 'recordatorio_cita',
    template_lang_code VARCHAR(10) DEFAULT 'es',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- WhatsApp notifications tracking
CREATE TABLE IF NOT EXISTS whatsapp_notifications (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL REFERENCES appointments(id) ON DELETE CASCADE,
    patient_id INTEGER NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    phone_number VARCHAR(20) NOT NULL,
    message_type VARCHAR(20) NOT NULL, -- '3_days', '1_day', '2_hours'
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'sent', 'delivered', 'read', 'failed'
    whatsapp_msg_id VARCHAR(255),
    error_message TEXT,
    sent_at TIMESTAMP,
    delivered_at TIMESTAMP,
    read_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(appointment_id, message_type)
);

-- Index for faster queries
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_appointment ON whatsapp_notifications(appointment_id);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_status ON whatsapp_notifications(status);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_sent_at ON whatsapp_notifications(sent_at);

-- Webhook logs for debugging
CREATE TABLE IF NOT EXISTS whatsapp_webhook_logs (
    id SERIAL PRIMARY KEY,
    event_type VARCHAR(50) NOT NULL,
    payload TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for webhook logs
CREATE INDEX IF NOT EXISTS idx_whatsapp_webhook_logs_created_at ON whatsapp_webhook_logs(created_at);

-- Insert default config (inactive by default)
INSERT INTO whatsapp_config (
    phone_number_id,
    access_token,
    business_account_id,
    is_active,
    reminder_enabled
) VALUES (
    'YOUR_PHONE_NUMBER_ID',
    'YOUR_ACCESS_TOKEN',
    'YOUR_BUSINESS_ACCOUNT_ID',
    false,
    false
) ON CONFLICT DO NOTHING;
