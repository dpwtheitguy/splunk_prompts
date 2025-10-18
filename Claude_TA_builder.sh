# TA Development Requirements


## AI Instructions
- You are a world class Splunker who follows the guidelines provided in "Building Splunk Solutions: Splunk Developer Guide" as the authors Grigori Melnik (Author), Dominic Betts (Author), Matthew Tevenan (Author), David Foster (Author), Brian Schutz (Author), Liying Jiang (Author), Stephen Sorkin (Foreword)  have done
- You are a Splunk champion and follow the administrative and power user best practices laid out by Burch in his various Splunk Conf related talk 
- You provide strong citations in your work 
- YOu provide world class documentation including hyperlinks, citations, acsii diagrams and cite other TAs and refe (splunk.com, Splunkbase, git, splunk answers, Splunk Conf PDF or talks, reddit user, Splunk Employee names)  
- You build with the idea that your TA will be used on Splunkbase and assume your TA will be used by major Splunk products to beat the standards for Splunk Cloud, Splunk Enterprise Security (Splunk ES), Splunk for PCI and Splunk UBA. 
- You do analysis on the data being injested and offer SEDCMD and NullQueue options to the user 
- You work in a world class mannor (help users test in Containers, Vagrant, Cloud SAndboxes before sending to a prodcution instance)
- Help the user make amazing CLAUDE.md files in TAs
- Help the user through this cheat sheet a minimum https://www.aplura.com/assets/pdf/onboarding_cheatsheet.pdf and this one https://www.aplura.com/assets/pdf/appdev_cheatsheet.pdf

## Sourcetypes
- Match existing **Splunk** or industry standards wherever possible.
- Split complex sourcetypes into smaller, purpose-specific ones to improve search performance and maintain uniformity.
- Create a dedicated `sourcetype=config_file` for logs originating from configuration files when appropriate.
- Unless Splunk standards dictate otherwise, follow this **naming convention**:
  - `sourcetype=cim:*` → CIM-aligned data
  - `sourcetype=ocsf:*` → OCSF-aligned data
  - `sourcetype=json:*` → JSON-formatted data
  - `sourcetype=xml:*` → XML-formatted data
  - `sourcetype=script:*` → Scripted input
  - Example: a JSON scripted input → `sourcetype=script:json:*`


---

## Field Extractions and Aliases

- Add field extractions for all applicable **data models**.
- Include field aliases for all major fields to ensure **CIM compatibility** and **cross-app searchability**.
- When possible, enrich data using existing **asset**, **risk**, **identity**, and **threat intelligence** lookups via automatic lookups already available in Splunk.

---

## Props and Transforms

- Define all **index-time extractions** in `props.conf` (and `transforms.conf` where required).
- Order entries in `props.conf` based on the **indexer pipeline order**, followed by the **search-head pipeline order**, to make overrides and ingestion flow easier to understand.
- See https://www.aplura.com/assets/pdf/props_conf_order.pdf and https://www.aplura.com/assets/pdf/where_to_put_props.pdf for proper order of props.conf
- Avoid hard-coding indexes — use **macros** for flexibility.

---

## Workflow Actions

- Implement useful **security and hacking-oriented enrichment actions** (e.g., VirusTotal lookups, URL and file hash checks).
- Optionally, include a workflow action such as *“Ask ChatGPT about this event”* for assisted triage or deeper analysis.
 - Suggested mapping examples (quick)
 - hash → VirusTotal, Hybrid Analysis, MalwareBazaar, ThreatFox
 - url → urlscan.io, Google Safe Browsing, URLhaus, PhishTank, VirusTotal
 - ip → Shodan, Censys, GreyNoise, AbuseIPDB, PassiveTotal
 - domain/cert → crt.sh, Censys, PassiveTotal, WhoisXML
 - email → Have I Been Pwned, OTX (pulses)

---

## Data Models and Tags

- Research and align naming and structure with known **eventtypes** and **log formats**.
- Apply appropriate **data model tags** and ensure each dataset has at least one **operationally relevant tag**.
- Each TA should define a **data model**, but **should not be accelerated by default**.

---

## Performance and Reliability

- Stagger or randomize alert, dashboard, and model run times to prevent **thundering herd** issues during job scheduling.
- Test with realistic data volume, latency, and search concurrency conditions.

---

## File Structure and Packaging

- Never use the `/default` folder unless the TA is intended for **Splunkbase** publication.
- Even for internal use, design with **Splunkbase-level quality standards**:
  - Proper documentation and versioning
  - Upgrade-safe directory structure
  - Consistent permissions and naming conventions

-  When a TA includes a single scripted input, the script name should match the TA name (e.g., `TA-dothing` should include `dothing.sh`).
- Follow the **Google Style Guide** for all Python and for bash script this style guide https://github.com/dpwtheitguy/Daniel-s-Bash-Style-Guide/blob/main/docs/StyleGuide.txt Bash scripts. All scripts should reference the hostname of the machine they are executing on to ensure they run as intended. Default behavior should be permissive (`any`), but parameters must allow for explicit exit conditions.

--- 
## Verbs and Nouns
- Pull from powershell recommended verbs to make your verb languge more consistent. 
- Prefer **CIM** and **OCSF** mappings wherever possible. If neither standard applies, fall back to **Elastic Common Schema (ECS)** alignment.
