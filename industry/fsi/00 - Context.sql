-- Databricks notebook source
-- MAGIC %md-sandbox
-- MAGIC # Lakehouse for Financial Services - Payments Lakehouse
-- MAGIC 
-- MAGIC ## Transaction reporting and monitoring
-- MAGIC 
-- MAGIC <p></p>
-- MAGIC <p></p>
-- MAGIC 
-- MAGIC <img src="https://raw.githubusercontent.com/rportilla-databricks/dbt-asset-mgmt/main/images/payments_lakehouse_overview.png" width="1000" />
-- MAGIC 
-- MAGIC <br/><br/>
-- MAGIC ## What is The Databricks Lakehouse?
-- MAGIC 
-- MAGIC The Databricks Lakehouse is a unified data platform, bringing together data warehouse and AI. This allows your business to not only run data analysis on existing data (what happened), but also build models to explain and proactively improve your business (what will happen and how to respond).
-- MAGIC 
-- MAGIC ### Simple
-- MAGIC   One single platform and governance/security layer for your data warehousing and AI to **accelerate innovation** and **reduce risks**. No need to stitch together multiple solutions with disparate governance and high complexity.
-- MAGIC 
-- MAGIC ### Open
-- MAGIC   Built on open source and open standards. You own your data and prevent vendor lock-in, with easy integration with external solution. Being open also lets you share your data with any external organization, regardless of their data stack/vendor.
-- MAGIC 
-- MAGIC ### Multicloud
-- MAGIC   One consistent data platform across clouds. Process your data where your need.
-- MAGIC   
-- MAGIC  <!-- Collect usage data (view). Remove it to disable collection. View README for more details.  -->
-- MAGIC <img width="1px" src="https://www.google-analytics.com/collect?v=1&gtm=GTM-NKQ8TT7&tid=UA-163989034-1&cid=555&aip=1&t=event&ec=field_demos&ea=display&dp=%2F42_field_demos%2Ffsi%2FPayments_Lakehouse%2FTransaction_Monitoring&dt=FSI_Payments_Lakehouse">

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Demo: Building a Payments Lakehouse and Monitoring Transactions with Databricks Lakehouse
-- MAGIC 
-- MAGIC In this demo, we spend a day in the life of a financial institution which has to do 2 things: 
-- MAGIC 
-- MAGIC * Report payments transactions to clearing/settlement institutions in the ISO 20022 format.
-- MAGIC * Read all payments using the standardized format and report on payments failures or customer behavior.
-- MAGIC 
-- MAGIC The business has determined that the ISO standardization will need to be done at scale globally. All payments must be summarized by region (failures, trends).
-- MAGIC 
-- MAGIC 
-- MAGIC ### What we'll build
-- MAGIC 
-- MAGIC To do so, we'll build the pipelines to curate payments and govern data with the Lakehouse architecture. We will create alerts to show transaction failures and report on geographic hot spots. Where there are areas of high volume or high failures, the business will be able to detect these simply with a DBSQL dashboard and email alert.
-- MAGIC 
-- MAGIC At a very high level, this is the data flow we'll implement.
-- MAGIC 
-- MAGIC <img width="1100px" src="https://raw.githubusercontent.com/rportilla-databricks/dbt-asset-mgmt/main/images/payments_lakehouse_arch_flow.png" />
-- MAGIC 
-- MAGIC 
-- MAGIC ### Our dataset
-- MAGIC 
-- MAGIC To simplify this demo, we'll consider that an external system is periodically sending data into our blob storage (S3/ADLS/GCS):
-- MAGIC 
-- MAGIC - Customer payment transaction data *demographic plus payment information like price and location*
-- MAGIC - XSD schemas to validate the ISO format
-- MAGIC 
-- MAGIC Let's see how this data can be used within the Lakehouse to centralize all payments data and get a global view of customers' transactions!  

-- COMMAND ----------

