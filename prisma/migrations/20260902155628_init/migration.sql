-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'MANAGER', 'ANALYST');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ANALYST',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "actorId" TEXT,
    "actorName" TEXT,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT,
    "detail" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClusterWindow" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "iso" TEXT NOT NULL,
    "season" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "openDate" TIMESTAMP(3),
    "closeDate" TIMESTAMP(3),
    "applications" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClusterWindow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "developer" TEXT NOT NULL,
    "technology" TEXT NOT NULL,
    "capacityMw" DOUBLE PRECISION NOT NULL,
    "queuePosition" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SiteControl" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "parcel" TEXT NOT NULL,
    "controlType" TEXT NOT NULL,
    "evidenceDate" TIMESTAMP(3),
    "status" TEXT NOT NULL,
    "acreage" DOUBLE PRECISION NOT NULL,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SiteControl_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepositRecord" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "phase" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,
    "dueDate" TIMESTAMP(3),
    "paidAt" TIMESTAMP(3),
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DepositRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClusterStudy" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "phase" TEXT NOT NULL,
    "lead" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "kickOff" TIMESTAMP(3),
    "projectCount" INTEGER NOT NULL,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClusterStudy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NetworkUpgrade" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "estimatedCost" DOUBLE PRECISION NOT NULL,
    "voltage" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "inServiceDate" TIMESTAMP(3),
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NetworkUpgrade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CostAllocation" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "upgradeRef" TEXT NOT NULL,
    "allocatedCost" DOUBLE PRECISION NOT NULL,
    "sharePct" DOUBLE PRECISION NOT NULL,
    "method" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CostAllocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Milestone" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "dueDate" TIMESTAMP(3),
    "metDate" TIMESTAMP(3),
    "status" TEXT NOT NULL,
    "consequence" TEXT,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Milestone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ModificationRequest" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "materiality" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "submittedAt" TIMESTAMP(3),
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ModificationRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GiaControl" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "draft" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "targetExecution" TIMESTAMP(3),
    "tenderedBy" TEXT,
    "version" TEXT NOT NULL,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GiaControl_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WithdrawalScenario" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "scenario" TEXT NOT NULL,
    "penaltyEstimate" DOUBLE PRECISION NOT NULL,
    "capitalAtRisk" DOUBLE PRECISION NOT NULL,
    "decision" TEXT NOT NULL,
    "modeledAt" TIMESTAMP(3),
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WithdrawalScenario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AffectedSystemStudy" (
    "id" TEXT NOT NULL,
    "projectRef" TEXT NOT NULL,
    "neighborSystem" TEXT NOT NULL,
    "finding" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "requestedAt" TIMESTAMP(3),
    "studyCost" DOUBLE PRECISION NOT NULL,
    "windowId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AffectedSystemStudy_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SiteControl" ADD CONSTRAINT "SiteControl_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepositRecord" ADD CONSTRAINT "DepositRecord_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClusterStudy" ADD CONSTRAINT "ClusterStudy_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NetworkUpgrade" ADD CONSTRAINT "NetworkUpgrade_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostAllocation" ADD CONSTRAINT "CostAllocation_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Milestone" ADD CONSTRAINT "Milestone_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModificationRequest" ADD CONSTRAINT "ModificationRequest_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GiaControl" ADD CONSTRAINT "GiaControl_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WithdrawalScenario" ADD CONSTRAINT "WithdrawalScenario_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffectedSystemStudy" ADD CONSTRAINT "AffectedSystemStudy_windowId_fkey" FOREIGN KEY ("windowId") REFERENCES "ClusterWindow"("id") ON DELETE SET NULL ON UPDATE CASCADE;
