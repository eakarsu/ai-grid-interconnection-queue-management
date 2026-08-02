CREATE TABLE IF NOT EXISTS app_users(
  id BIGSERIAL PRIMARY KEY,email TEXT UNIQUE NOT NULL,name TEXT NOT NULL,role TEXT NOT NULL,password_hash TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS workflow_cases(
  id BIGSERIAL PRIMARY KEY,workflow_id TEXT NOT NULL,reference TEXT UNIQUE NOT NULL,subject TEXT NOT NULL,owner TEXT NOT NULL,state TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,payload JSONB NOT NULL DEFAULT '{}'::jsonb,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS audit_events(
  id BIGSERIAL PRIMARY KEY,event_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),actor TEXT NOT NULL,action TEXT NOT NULL,object_type TEXT NOT NULL,object_reference TEXT NOT NULL,detail TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS saved_analyses(
  id BIGSERIAL PRIMARY KEY,workflow_id TEXT NOT NULL,actor TEXT NOT NULL,analysis_type TEXT NOT NULL,inputs JSONB NOT NULL,result JSONB NOT NULL,provider TEXT NOT NULL,model TEXT,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS integration_state(
  id TEXT PRIMARY KEY,name TEXT NOT NULL,category TEXT NOT NULL,mode TEXT NOT NULL,status TEXT NOT NULL,last_tested TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_workflow_cases_workflow ON workflow_cases(workflow_id);
CREATE INDEX IF NOT EXISTS idx_workflow_cases_due ON workflow_cases(due_date);
CREATE INDEX IF NOT EXISTS idx_audit_events_time ON audit_events(event_time DESC);

CREATE TABLE IF NOT EXISTS "op_readiness"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_capacityMw" NUMERIC(16,2) NOT NULL,
  "data_siteControl" TEXT NOT NULL,
  "data_readinessNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_readiness_due ON "op_readiness"(due_date);

CREATE TABLE IF NOT EXISTS "op_cluster"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_cluster" TEXT NOT NULL,
  "data_projectCount" NUMERIC(16,2) NOT NULL,
  "data_studyDue" DATE NOT NULL,
  "data_studyNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_cluster_due ON "op_cluster"(due_date);

CREATE TABLE IF NOT EXISTS "op_network_upgrade"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_upgrade" TEXT NOT NULL,
  "data_estimatedCost" NUMERIC(16,2) NOT NULL,
  "data_allocatedShare" NUMERIC(16,2) NOT NULL,
  "data_allocationBasis" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_network_upgrade_due ON "op_network_upgrade"(due_date);

CREATE TABLE IF NOT EXISTS "op_affected_system"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_affectedSystem" TEXT NOT NULL,
  "data_studyAgreement" TEXT NOT NULL,
  "data_responseDue" DATE NOT NULL,
  "data_coordinationNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_affected_system_due ON "op_affected_system"(due_date);

CREATE TABLE IF NOT EXISTS "op_milestone"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_milestone" TEXT NOT NULL,
  "data_milestoneDue" DATE NOT NULL,
  "data_evidence" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_milestone_due ON "op_milestone"(due_date);

CREATE TABLE IF NOT EXISTS "op_material_modification"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_changeType" TEXT NOT NULL,
  "data_capacityChangeMw" NUMERIC(16,2) NOT NULL,
  "data_impactAnalysis" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_material_modification_due ON "op_material_modification"(due_date);

CREATE TABLE IF NOT EXISTS "op_gia"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_agreementVersion" TEXT NOT NULL,
  "data_securityAmount" NUMERIC(16,2) NOT NULL,
  "data_openTerms" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_gia_due ON "op_gia"(due_date);

CREATE TABLE IF NOT EXISTS "op_portfolio"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_portfolio" TEXT NOT NULL,
  "data_withdrawalRate" NUMERIC(16,2) NOT NULL,
  "data_capitalAtRisk" NUMERIC(16,2) NOT NULL,
  "data_scenarioNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_portfolio_due ON "op_portfolio"(due_date);

CREATE TABLE IF NOT EXISTS "op_project_register"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_technology" TEXT NOT NULL,
  "data_capacityMw" NUMERIC(16,2) NOT NULL,
  "data_targetCod" DATE NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_project_register_due ON "op_project_register"(due_date);

CREATE TABLE IF NOT EXISTS "op_cluster_register"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_cluster" TEXT NOT NULL,
  "data_region" TEXT NOT NULL,
  "data_projectCount" NUMERIC(16,2) NOT NULL,
  "data_studyDue" DATE NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_cluster_register_due ON "op_cluster_register"(due_date);

CREATE TABLE IF NOT EXISTS "op_upgrade_register"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_upgrade" TEXT NOT NULL,
  "data_facility" TEXT NOT NULL,
  "data_estimatedCost" NUMERIC(16,2) NOT NULL,
  "data_inServiceDate" DATE NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_upgrade_register_due ON "op_upgrade_register"(due_date);

CREATE TABLE IF NOT EXISTS "op_security_register"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_securityType" TEXT NOT NULL,
  "data_amount" NUMERIC(16,2) NOT NULL,
  "data_dueDate" DATE NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_security_register_due ON "op_security_register"(due_date);
