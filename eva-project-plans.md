Below is the complete, redrafted multi-phase TDD implementation plan for Eva—your Executive Virtual Assistant. This plan now includes not only unit tests (ensuring near-100% coverage of core functions) but also integration, end-to-end, user acceptance, performance, and security tests to give you the confidence to ship to production and acquire paying, happy customers.

Each phase is described in its own Markdown file under the `docs/` folder. The overall project is modular, follows PEP8 guidelines, and is organized so that each code file stays under 500 lines (ideally under 250). External integrations (Google Calendar API, OpenAI GPT API) are mocked in tests until real credentials and endpoints are available. The plan is iterative, with each module built, tested, and refined before moving on.

---

## Folder Structure Overview

```
eva-project/
├── .gitignore
├── README.md
├── requirements.txt
├── robots.txt
├── docs/
│   ├── README.md
│   ├── FolderStructure.md
│   ├── Phase1_Setup.md
│   ├── Phase2_PlanningEngine.md
│   ├── Phase3_ConversationLayer.md
│   ├── Phase4_RealTimeDashboard.md
│   └── Testing.md
└── src/
    ├── eva/
    │   ├── __init__.py
    │   ├── main.py
    │   ├── calendar_integration.py
    │   ├── planning_engine.py
    │   ├── conversation.py
    │   ├── dashboard.py
    │   └── utils.py
    └── tests/
        ├── test_setup.py
        ├── test_calendar_integration.py
        ├── test_planning_engine.py
        ├── test_conversation.py
        ├── test_dashboard.py
        ├── test_integration.py
        ├── test_e2e.py
        ├── test_user_acceptance.py
        ├── test_performance.py
        └── test_security.py
```

---

## File: requirements.txt

```txt
# requirements.txt
openai==0.27.0
google-api-python-client==2.70.0
google-auth==2.18.0
streamlit==1.25.0
pytest==7.2.0
flake8==5.0.4
requests==2.28.1
```

---

## File: robots.txt

```txt
# robots.txt
User-agent: *
Disallow:
```

---

## File: docs/README.md

```markdown
# Eva: Your Executive Virtual Assistant

Eva is an AI-powered life co-pilot designed to help busy executives, founders, and new parents structure their week so they can live confidently. Eva creates a weekly plan that reflects your top priorities, adapts in real time, and tracks planned versus actual outcomes—all while engaging in natural, human conversation.

This documentation outlines our Test-Driven Development (TDD) approach. We build, test, and refine each function iteratively to ensure robust, production-ready code that delivers an exceptional user experience.

## Overview of Phases

1. **Phase 1:** Setup & Environment Configuration  
2. **Phase 2:** Planning Engine (Weekly Plan Creation)  
3. **Phase 3:** Conversation Layer (Natural Language Interactions)  
4. **Phase 4:** Real-Time Dashboard (Actual vs. Ideal Tracking)  
5. **Testing:** Comprehensive TDD including unit, integration, end-to-end (E2E), user acceptance, performance, and security tests

Each phase is described in detail in the following Markdown documents.
```

---

## File: docs/FolderStructure.md

```markdown
# Folder Structure

This project is organized to support a modular, TDD-based approach with clear separation of responsibilities:

```
eva-project/
├── .gitignore                 # Git ignore settings
├── README.md                  # Project overview
├── requirements.txt           # Python dependencies
├── robots.txt                 # Web crawler instructions
├── docs/                      # Documentation files:
│   ├── README.md              # Overview of Eva
│   ├── FolderStructure.md     # This file
│   ├── Phase1_Setup.md        # Environment and setup instructions
│   ├── Phase2_PlanningEngine.md  # Weekly planning engine details
│   ├── Phase3_ConversationLayer.md  # Conversation layer details
│   ├── Phase4_RealTimeDashboard.md   # Real-time dashboard details
│   └── Testing.md             # TDD strategy and comprehensive test cases
└── src/                       # Source code:
    ├── eva/                   # Eva's core functionality
    │   ├── __init__.py
    │   ├── main.py            # Application entry point
    │   ├── calendar_integration.py   # Google Calendar API integration
    │   ├── planning_engine.py        # Weekly planning logic
    │   ├── conversation.py           # Conversation handling logic
    │   ├── dashboard.py              # Real-time dashboard functions
    │   └── utils.py                  # Utility functions
    └── tests/                 # Test cases:
        ├── test_setup.py
        ├── test_calendar_integration.py
        ├── test_planning_engine.py
        ├── test_conversation.py
        ├── test_dashboard.py
        ├── test_integration.py
        ├── test_e2e.py
        ├── test_user_acceptance.py
        ├── test_performance.py
        └── test_security.py
```

This organization ensures:
- **Modularity:** Each module has a single responsibility.
- **Testability:** Every function is covered by unit tests; integration and E2E tests validate module interactions.
- **Maintainability:** Files remain concise and under the prescribed line limits.
```

---

## File: docs/Phase1_Setup.md

```markdown
# Phase 1: Setup & Environment Configuration

In Phase 1, we establish the project foundation. We set up the repository, virtual environment, folder structure, and our initial testing framework.

## Objectives

- Initialize the repository and virtual environment.
- Create the folder structure (see FolderStructure.md).
- Install dependencies from `requirements.txt`.
- Create initial stub files in `src/eva/` with basic functionality.
- Write a smoke test to verify that all modules import correctly.

## Steps

1. **Repository Initialization**
   - Run `git init` in the project root.
   - Create a `.gitignore` file to exclude virtual environments, compiled files, etc.

2. **Environment Setup**
   - Create and activate a Python virtual environment.
   - Install dependencies:
     ```bash
     pip install -r requirements.txt
     ```

3. **Folder Structure**
   - Create directories: `docs/`, `src/eva/`, and `src/tests/`.
   - Add empty `__init__.py` files in `src/eva/`.

4. **Initial Smoke Test**
   - Create `src/tests/test_setup.py`:
     ```python
     # src/tests/test_setup.py
     def test_imports():
         from eva import main, calendar_integration, planning_engine, conversation, dashboard
         assert main is not None
     ```

5. **Continuous Integration**
   - (Optional) Configure a CI pipeline (e.g., GitHub Actions) to run `pytest` on each commit.

## Expected Outcome

- Running `pytest` should pass the smoke test.
- The repository structure is correctly set up and ready for further development.

## Next Steps

Proceed to **Phase 2: Building the Planning Engine**.
```

---

## File: docs/Phase2_PlanningEngine.md

```markdown
# Phase 2: Planning Engine

The Planning Engine creates Eva’s weekly plan based on user priorities and existing calendar events.

## Objectives

- Build functions in `src/eva/planning_engine.py` to:
  - Parse natural language input into structured priorities.
  - Generate a weekly plan that respects existing calendar events.
- Develop stubs and tests using TDD.

## Steps

1. **Parse User Input**
   - Create `parse_priorities(input_str: str) -> dict` in `src/eva/planning_engine.py`.
   - Write tests in `src/tests/test_planning_engine.py`:
     ```python
     # src/tests/test_planning_engine.py
     def test_parse_priorities():
         from eva.planning_engine import parse_priorities
         input_str = "I need 3 workouts, 2 deep work sessions, and 1 family dinner."
         priorities = parse_priorities(input_str)
         assert priorities["workouts"] == 3
         assert priorities["deep_work"] == 2
         assert priorities["family_dinner"] == 1
     ```

2. **Calendar Integration Stub**
   - In `src/eva/calendar_integration.py`, create a stub function `get_week_events()` that returns dummy events.
   - Write tests in `src/tests/test_calendar_integration.py` to verify event format.

3. **Weekly Plan Generation**
   - Create `generate_weekly_plan(priorities: dict, events: list) -> dict` in `src/eva/planning_engine.py`.
   - Write tests:
     ```python
     def test_generate_weekly_plan():
         from eva.planning_engine import generate_weekly_plan
         dummy_priorities = {"workouts": 3, "deep_work": 2, "family_dinner": 1}
         dummy_events = [{"start": "2023-01-01T09:00", "end": "2023-01-01T10:00"}]
         plan = generate_weekly_plan(dummy_priorities, dummy_events)
         assert "workouts" in plan
         # Assert that time blocks do not overlap
     ```

4. **Utilities and Refactoring**
   - Add helper functions to `src/eva/utils.py` as needed.
   - Maintain PEP8 compliance and file size limits.

## Expected Outcome

- Eva’s planning engine correctly parses priorities and generates a weekly plan that avoids conflicts.
- All unit tests pass.

## Next Steps

Once stable, move to **Phase 3: Building the Conversation Layer**.
```

---

## File: docs/Phase3_ConversationLayer.md

```markdown
# Phase 3: Conversation Layer

This phase adds Eva’s natural language interface, enabling dynamic interaction and plan adjustments.

## Objectives

- Integrate with OpenAI’s GPT API for natural language processing.
- Build a conversation function in `src/eva/conversation.py`:
  - `handle_conversation(input_str: str, current_plan: dict) -> dict`
- Develop tests covering various conversational scenarios.

## Steps

1. **Define the Conversation Interface**
   - Implement `handle_conversation` in `src/eva/conversation.py`.
   - Write tests in `src/tests/test_conversation.py`:
     ```python
     def test_handle_conversation_update():
         from eva.conversation import handle_conversation
         current_plan = {"deep_work": {"time": "09:00-10:30"}}
         input_str = "I want to push my deep work session to later."
         updated_plan = handle_conversation(input_str, current_plan)
         assert updated_plan["deep_work"]["time"] != "09:00-10:30"
     ```

2. **GPT API Integration**
   - In `src/eva/utils.py`, add `query_gpt(prompt: str) -> str` to interface with OpenAI.
   - Use mocks in tests to simulate API responses.

3. **Interactive Flow**
   - In `src/eva/main.py`, set up an interactive loop or Streamlit interface that:
     - Displays the current plan.
     - Accepts user input.
     - Updates the plan using `handle_conversation`.

## Expected Outcome

- Eva can converse naturally to update the weekly plan.
- Conversation module tests pass with reliable handling of input.

## Next Steps

Proceed to **Phase 4: Building the Real-Time Dashboard**.
```

---

## File: docs/Phase4_RealTimeDashboard.md

```markdown
# Phase 4: Real-Time Dashboard

The Real-Time Dashboard displays planned versus actual events, providing dynamic feedback and nudges.

## Objectives

- Develop functions in `src/eva/dashboard.py` to:
  - Compare the ideal plan with actual calendar events.
  - Generate a real-time report.
- Build a UI (using Streamlit or a similar framework) for visualization.
- Write tests to simulate and verify dashboard behavior.

## Steps

1. **Design the Data Comparison Model**
   - Implement `compare_plan_actual(plan: dict, actual_events: list) -> dict` in `src/eva/dashboard.py`.
   - Write tests in `src/tests/test_dashboard.py`:
     ```python
     def test_compare_plan_actual():
         from eva.dashboard import compare_plan_actual
         plan = {"deep_work": {"time": "09:00-10:30", "status": "planned"}}
         actual = [{"summary": "Meeting", "start": "2023-01-01T09:00", "end": "2023-01-01T09:45"}]
         report = compare_plan_actual(plan, actual)
         assert "deep_work" in report
         # Assert that deviations are correctly flagged
     ```

2. **Build the Dashboard UI**
   - Develop a Streamlit-based UI in `src/eva/dashboard.py` (or `src/dashboard_app.py`) to:
     - Display planned vs. actual events with color coding.
     - Refresh in real time.
   
3. **Nudging and Feedback System**
   - Add functions to trigger nudges if significant deviations are detected.
   - Write tests that simulate various deviation scenarios.

## Expected Outcome

- Eva’s dashboard offers a clear, real-time view of planned and actual outcomes.
- All dashboard tests pass, confirming accurate reporting.

## Next Steps

After completing this phase, integrate all modules in `src/eva/main.py` for a full-cycle demo.
```

---

## File: docs/Testing.md

```markdown
# Testing Strategy and TDD Methodology

Our TDD approach for Eva ensures every module is thoroughly tested before integration. We cover unit tests, integration tests, end-to-end (E2E) tests, user acceptance tests, performance tests, and security tests.

## General Principles

- **Write Tests First:** For every new function, create a failing test.
- **Modularity:** Each test focuses on one behavior or edge case.
- **Mock External Services:** Use mocks for Google Calendar and OpenAI GPT API.
- **Continuous Testing:** Run `pytest` frequently and integrate with a CI pipeline.
- **PEP8 Compliance:** Use tools like flake8 for style checks.

## Module Testing

1. **Unit Tests**
   - *Calendar Integration:*  
     - Test that `get_week_events()` returns the correct format.
     - Handle API errors gracefully.
   - *Planning Engine:*  
     - Test `parse_priorities` and `generate_weekly_plan` functions.
   - *Conversation Layer:*  
     - Test `handle_conversation` with various inputs.
   - *Dashboard:*  
     - Test `compare_plan_actual` to validate deviation reporting.

2. **Integration Tests**
   - Create `src/tests/test_integration.py` to verify interactions between modules (e.g., conversation updates the plan, which is reflected in the dashboard).

3. **End-to-End (E2E) Tests**
   - Create `src/tests/test_e2e.py` simulating a full user flow:
     - Input priorities.
     - Generate plan.
     - Adjust plan via conversation.
     - Render dashboard output.
   
4. **User Acceptance Tests (UAT)**
   - Create `src/tests/test_user_acceptance.py` (or use a framework like Selenium for UI tests) to simulate real user interactions and verify the experience.
   
5. **Performance Tests**
   - Create `src/tests/test_performance.py` to benchmark the performance of key functions, ensuring the system responds within acceptable limits.
   
6. **Security Tests**
   - Create `src/tests/test_security.py` to validate that external integrations and data handling meet security standards (e.g., proper handling of API keys, data sanitization).

## Running Tests

Use the following command to run the entire test suite:
```bash
pytest --maxfail=1 --disable-warnings -q
```

## Expected Outcome

- Unit tests cover nearly 100% of the core functions.
- Integration and E2E tests ensure that modules work together seamlessly.
- UAT, performance, and security tests provide confidence in production-readiness.
- Continuous feedback via CI/CD helps maintain quality as new features are added.

## Continuous Improvement

After shipping the MVP, additional tests and refinements (especially around user experience and edge cases) will further improve reliability and customer satisfaction.
```

---

## Final Notes

- **Core Coverage:** Our plan targets near-100% unit test coverage of the core feature set through rigorous TDD.
- **Integration & Beyond:** Additional integration, end-to-end, user acceptance, performance, and security tests ensure that Eva not only functions correctly but also delivers a delightful and secure user experience.
- **Iterative Development:** Each phase is built, tested, and refined before proceeding, ensuring a robust foundation for production.
- **Modular & Maintainable:** All files are organized to keep each module concise (ideally <250 lines per code file) and follow PEP8 style guidelines.

This complete multi-phase plan provides a clear, test-driven roadmap to build Eva—ensuring that when you ship, you have a production-ready system that meets the needs of busy executives and delivers a compelling user experience.

Would you like additional sample code for any module, or any further refinements?
