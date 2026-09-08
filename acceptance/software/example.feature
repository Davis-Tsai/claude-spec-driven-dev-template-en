# =====================================================================
# Acceptance Tests (Software) — Executable Specification
# status: Draft
# Description: Uses Gherkin syntax to describe acceptance criteria (AC). This is the
#              basis for judging "successful restoration". After rebuilding the code,
#              all scenarios here must pass.
# =====================================================================

# ⚠️ example — delete when starting real content: the scenarios below are a format demo; you can replace the whole file with your own acceptance criteria.

Feature: Device telemetry reporting (maps to FR-001)

  Scenario: AC-001 Registered device reports telemetry successfully
    Given a device with serial number "SN-1001" exists
    When the device reports ts and value as valid JSON
    Then the API responds with status code 201
    And the telemetry data is written to the telemetry table

  Scenario: AC-002 Reporting from an unregistered device should be rejected
    Given no device with serial number "SN-9999" exists
    When telemetry is reported with serial number "SN-9999"
    Then the API responds with status code 404

  Scenario: AC-003 Malformed data should be rejected
    Given a device with serial number "SN-1001" exists
    When data missing the value field is reported
    Then the API responds with status code 400
