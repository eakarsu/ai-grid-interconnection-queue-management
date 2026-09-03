export interface PageConfig {
  label: string;
  href: string;
  description: string;
  entities: string[];
  workflows: string[];
}

export interface EntityConfig {
  name: string;
  label: string;
  fields: Array<{ name: string; kind: "string" | "number" | "boolean" | "date" }>;
}

export interface WorkflowConfig {
  slug: string;
  title: string;
  description: string;
  prompt: string;
  fields: string[];
}

export const appConfig = {
  slug: "ai-grid-interconnection-queue-management",
  title: "GridQueue Interconnection Control",
  tagline: "FERC Order 2023 interconnection queue operations",
  accent: "violet",
};

export const pages: PageConfig[] = [
  {
    label: "Queue Portfolio",
    href: "/queue",
    description: "Cluster windows, projects, readiness.",
    entities: ["ClusterWindow", "Project", "SiteControl", "DepositRecord"],
    workflows: ["readiness-check"],
  },
  {
    label: "Studies",
    href: "/studies",
    description: "Cluster studies, network upgrades, affected systems.",
    entities: ["ClusterStudy", "NetworkUpgrade", "AffectedSystemStudy"],
    workflows: ["cost-allocate"],
  },
  {
    label: "Costs & Milestones",
    href: "/costs",
    description: "Cost allocation and milestone compliance.",
    entities: ["CostAllocation", "Milestone"],
    workflows: [],
  },
  {
    label: "GIA & Risk",
    href: "/gia",
    description: "GIA execution control, modifications, withdrawal scenarios.",
    entities: ["GiaControl", "ModificationRequest", "WithdrawalScenario"],
    workflows: ["withdrawal-model"],
  },
];

export const entities: Record<string, EntityConfig> = {
  ClusterWindow: {
    name: "ClusterWindow",
    label: "Cluster Window",
    fields: [{ name: "name", kind: "string" }, { name: "iso", kind: "string" }, { name: "season", kind: "string" }, { name: "status", kind: "string" }, { name: "openDate", kind: "date" }, { name: "closeDate", kind: "date" }, { name: "applications", kind: "number" }],
  },
  Project: {
    name: "Project",
    label: "Interconnection Project",
    fields: [{ name: "name", kind: "string" }, { name: "developer", kind: "string" }, { name: "technology", kind: "string" }, { name: "capacityMw", kind: "number" }, { name: "queuePosition", kind: "string" }, { name: "status", kind: "string" }],
  },
  SiteControl: {
    name: "SiteControl",
    label: "Site Control",
    fields: [{ name: "projectRef", kind: "string" }, { name: "parcel", kind: "string" }, { name: "controlType", kind: "string" }, { name: "evidenceDate", kind: "date" }, { name: "status", kind: "string" }, { name: "acreage", kind: "number" }],
  },
  DepositRecord: {
    name: "DepositRecord",
    label: "Deposit",
    fields: [{ name: "projectRef", kind: "string" }, { name: "phase", kind: "string" }, { name: "amount", kind: "number" }, { name: "status", kind: "string" }, { name: "dueDate", kind: "date" }, { name: "paidAt", kind: "date" }],
  },
  ClusterStudy: {
    name: "ClusterStudy",
    label: "Cluster Study",
    fields: [{ name: "name", kind: "string" }, { name: "phase", kind: "string" }, { name: "lead", kind: "string" }, { name: "status", kind: "string" }, { name: "kickOff", kind: "date" }, { name: "projectCount", kind: "number" }],
  },
  NetworkUpgrade: {
    name: "NetworkUpgrade",
    label: "Network Upgrade",
    fields: [{ name: "name", kind: "string" }, { name: "kind", kind: "string" }, { name: "estimatedCost", kind: "number" }, { name: "voltage", kind: "string" }, { name: "status", kind: "string" }, { name: "inServiceDate", kind: "date" }],
  },
  CostAllocation: {
    name: "CostAllocation",
    label: "Cost Allocation",
    fields: [{ name: "projectRef", kind: "string" }, { name: "upgradeRef", kind: "string" }, { name: "allocatedCost", kind: "number" }, { name: "sharePct", kind: "number" }, { name: "method", kind: "string" }, { name: "status", kind: "string" }],
  },
  Milestone: {
    name: "Milestone",
    label: "Milestone",
    fields: [{ name: "projectRef", kind: "string" }, { name: "kind", kind: "string" }, { name: "dueDate", kind: "date" }, { name: "metDate", kind: "date" }, { name: "status", kind: "string" }, { name: "consequence", kind: "string" }],
  },
  ModificationRequest: {
    name: "ModificationRequest",
    label: "Modification Request",
    fields: [{ name: "projectRef", kind: "string" }, { name: "kind", kind: "string" }, { name: "description", kind: "string" }, { name: "materiality", kind: "string" }, { name: "status", kind: "string" }, { name: "submittedAt", kind: "date" }],
  },
  GiaControl: {
    name: "GiaControl",
    label: "GIA Control",
    fields: [{ name: "projectRef", kind: "string" }, { name: "draft", kind: "string" }, { name: "status", kind: "string" }, { name: "targetExecution", kind: "date" }, { name: "tenderedBy", kind: "string" }, { name: "version", kind: "string" }],
  },
  WithdrawalScenario: {
    name: "WithdrawalScenario",
    label: "Withdrawal Scenario",
    fields: [{ name: "projectRef", kind: "string" }, { name: "scenario", kind: "string" }, { name: "penaltyEstimate", kind: "number" }, { name: "capitalAtRisk", kind: "number" }, { name: "decision", kind: "string" }, { name: "modeledAt", kind: "date" }],
  },
  AffectedSystemStudy: {
    name: "AffectedSystemStudy",
    label: "Affected System Study",
    fields: [{ name: "projectRef", kind: "string" }, { name: "neighborSystem", kind: "string" }, { name: "finding", kind: "string" }, { name: "status", kind: "string" }, { name: "requestedAt", kind: "date" }, { name: "studyCost", kind: "number" }],
  },
};

export const workflows: WorkflowConfig[] = [
  {
    slug: "readiness-check",
    title: "Queue Readiness Reviewer",
    description: "Assess FERC Order 2023 application readiness.",
    prompt: "You are an interconnection policy analyst. Under FERC Order 2023, review the application readiness: site control, deposits, executing milestones. List gaps and cure deadlines.",
    fields: ["project", "siteControlType", "depositsPaid", "clusterPhase"],
  },
  {
    slug: "cost-allocate",
    title: "Upgrade Cost Allocator",
    description: "Allocation of network upgrade costs across cluster.",
    prompt: "You are a transmission-cost analyst. Allocate network upgrade costs across cluster projects proportional to allocated capacity and explain the method's compliance.",
    fields: ["upgradeCost", "projectCapacities", "method", "iso"],
  },
  {
    slug: "withdrawal-model",
    title: "Withdrawal Risk Modeler",
    description: "Model withdrawal penalties and capital at risk.",
    prompt: "You are an energy markets analyst. Model this withdrawal scenario: penalties, lost deposits, and knock-on effects for remaining cluster members.",
    fields: ["project", "stageOfStudy", "depositsAtRisk", "clusterSize"],
  },
];

export function findPage(href: string): PageConfig | undefined {
  return pages.find((p) => p.href === href);
}
