// Seed script — creates demo users and realistic domain records.
import { PrismaClient, Role } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

const phones = ["(415) 555-0132", "(212) 555-0187", "(312) 555-0149", "(617) 555-0110"];
const cities = ["Chicago, IL", "Austin, TX", "Boston, MA", "Denver, CO", "Seattle, WA"];

function pick<T>(arr: T[], i: number): T { return arr[i % arr.length]; }
function amount(i: number, base = 1000): number { return Math.round((base + ((i * 7919) % 900) * base) * 100) / 100; }
function daysAgo(i: number, spread = 180): Date { return new Date(Date.now() - ((i * 37) % spread) * 86400000); }

async function main() {
  const passwordHash = await bcrypt.hash("Demo!23456", 12);
  const demoUsers: Array<[string, string, Role]> = [
    ["admin@ai-grid-interconnection-queue-management.local", "Demo Admin", "ADMIN"],
    ["manager@ai-grid-interconnection-queue-management.local", "Demo Manager", "MANAGER"],
    ["analyst@ai-grid-interconnection-queue-management.local", "Demo Analyst", "ANALYST"],
  ];
  for (const [email, name, role] of demoUsers) {
    await prisma.user.upsert({ where: { email }, update: {}, create: { email, name, role, passwordHash } });
  }

  const STATUSES_ClusterWindow = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.clusterWindow.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.clusterWindow.create({
      data: {
      name: `Name ${String(i + 1).padStart(3, "0")}`,
      iso: `Iso ${String(i + 1).padStart(3, "0")}`,
      season: `Season ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_ClusterWindow, i),
      openDate: daysAgo(i),
      closeDate: daysAgo(i),
      applications: 5 + ((i * 13) % 95)
      },
    });
  }

  const clusterWindowRefs = await prisma.clusterWindow.findMany({ select: { id: true } });

  const STATUSES_Project = ["QUEUE", "READY", "STUDY", "GIA", "WITHDRAWN"];
  await prisma.project.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.project.create({
      data: {
      name: `Name ${String(i + 1).padStart(3, "0")}`,
      developer: `Developer ${String(i + 1).padStart(3, "0")}`,
      technology: `Technology ${String(i + 1).padStart(3, "0")}`,
      capacityMw: amount(i, 250),
      queuePosition: `QueuePosition ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_Project, i),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_SiteControl = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.siteControl.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.siteControl.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      parcel: `Parcel ${String(i + 1).padStart(3, "0")}`,
      controlType: `ControlType ${String(i + 1).padStart(3, "0")}`,
      evidenceDate: daysAgo(i),
      status: pick(STATUSES_SiteControl, i),
      acreage: amount(i, 250),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_DepositRecord = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.depositRecord.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.depositRecord.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      phase: `Phase ${String(i + 1).padStart(3, "0")}`,
      amount: amount(i, 250),
      status: pick(STATUSES_DepositRecord, i),
      dueDate: daysAgo(i),
      paidAt: daysAgo(i),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_ClusterStudy = ["PLANNED", "ACTIVE", "DRAFTED", "FINAL"];
  await prisma.clusterStudy.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.clusterStudy.create({
      data: {
      name: `Name ${String(i + 1).padStart(3, "0")}`,
      phase: `Phase ${String(i + 1).padStart(3, "0")}`,
      lead: `Lead ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_ClusterStudy, i),
      kickOff: daysAgo(i),
      projectCount: 5 + ((i * 13) % 95),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_NetworkUpgrade = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.networkUpgrade.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.networkUpgrade.create({
      data: {
      name: `Name ${String(i + 1).padStart(3, "0")}`,
      kind: `Kind ${String(i + 1).padStart(3, "0")}`,
      estimatedCost: amount(i, 250),
      voltage: `Voltage ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_NetworkUpgrade, i),
      inServiceDate: daysAgo(i),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_CostAllocation = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.costAllocation.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.costAllocation.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      upgradeRef: `UpgradeRef ${String(i + 1).padStart(3, "0")}`,
      allocatedCost: amount(i, 250),
      sharePct: amount(i, 250),
      method: `Method ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_CostAllocation, i),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_Milestone = ["PENDING", "MET", "MISSED", "WAIVED"];
  await prisma.milestone.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.milestone.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      kind: `Kind ${String(i + 1).padStart(3, "0")}`,
      dueDate: daysAgo(i),
      metDate: daysAgo(i),
      status: pick(STATUSES_Milestone, i),
      consequence: `Consequence ${String(i + 1).padStart(3, "0")}`,
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_ModificationRequest = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.modificationRequest.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.modificationRequest.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      kind: `Kind ${String(i + 1).padStart(3, "0")}`,
      description: `Description ${String(i + 1).padStart(3, "0")}`,
      materiality: `Materiality ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_ModificationRequest, i),
      submittedAt: daysAgo(i),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_GiaControl = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.giaControl.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.giaControl.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      draft: `Draft ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_GiaControl, i),
      targetExecution: daysAgo(i),
      tenderedBy: `TenderedBy ${String(i + 1).padStart(3, "0")}`,
      version: `Version ${String(i + 1).padStart(3, "0")}`,
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_WithdrawalScenario = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.withdrawalScenario.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.withdrawalScenario.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      scenario: `Scenario ${String(i + 1).padStart(3, "0")}`,
      penaltyEstimate: amount(i, 250),
      capitalAtRisk: amount(i, 250),
      decision: `Decision ${String(i + 1).padStart(3, "0")}`,
      modeledAt: daysAgo(i),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  const STATUSES_AffectedSystemStudy = ["OPEN", "IN_REVIEW", "APPROVED", "CLOSED"];
  await prisma.affectedSystemStudy.deleteMany();
  for (let i = 0; i < 25; i++) {
    await prisma.affectedSystemStudy.create({
      data: {
      projectRef: `ProjectRef ${String(i + 1).padStart(3, "0")}`,
      neighborSystem: `NeighborSystem ${String(i + 1).padStart(3, "0")}`,
      finding: `Finding ${String(i + 1).padStart(3, "0")}`,
      status: pick(STATUSES_AffectedSystemStudy, i),
      requestedAt: daysAgo(i),
      studyCost: amount(i, 250),
      window: { connect: { id: clusterWindowRefs[i % clusterWindowRefs.length].id } }
      },
    });
  }

  await prisma.auditLog.create({ data: { actorName: "Seeder", action: "SEED", entity: "system", detail: "Demo dataset created" } });

  console.log("Seeded demo users and domain records.");
}

main().catch((e) => { console.error(e); process.exit(1); }).finally(async () => { await prisma.$disconnect(); });
