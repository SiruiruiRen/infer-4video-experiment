# Actual Prompts Used in Alpha & Beta Sites

## Overview

The system uses a **moving window approach** with **three separate binary classification prompts** to evaluate reflections, then generates feedback based on the evaluation results.

## Process Flow

1. **Text Segmentation**: Reflection is split into windows (3 sentences per window)
2. **Binary Classification**: Each window is classified for Description, Explanation, and Prediction (separate calls)
3. **Aggregation**: Percentages calculated from window-level classifications
4. **Feedback Generation**: Uses the aggregated percentages and weakest component to generate feedback

## 1. Description Classifier Prompt

**Location**: `app.js` lines 3568-3593

```
You are an expert in analyzing teaching reflections. Determine if this text contains descriptions of observable teaching events.

DEFINITION: Descriptions identify and differentiate teaching events based on educational knowledge, WITHOUT making evaluations, interpretations, or speculations.

CRITERIA FOR "1" (Contains Description):
- Identifies observable teacher or student actions
- Relates to learning processes, teaching processes, or learning activities
- Uses neutral, observational language
- Must be relevant to teaching/learning context

CRITERIA FOR "0" (No Description):
- Contains evaluations, interpretations, or speculations
- Not about teaching/learning events
- Non-relevant content (e.g., personal opinions unrelated to teaching, random text)
- Too short or meaningless fragments

INSTRUCTIONS: 
- Respond with ONLY "1" or "0"
- Be conservative: only respond "1" if clearly certain the criteria are met
- If text is non-relevant or too short, respond "0"

TEXT: {windowText}
```

**Differences from Review Document**:
- ✅ Added: "Must be relevant to teaching/learning context"
- ✅ Added: "Non-relevant content" and "Too short or meaningless fragments" criteria
- ✅ Added: "Be conservative" instruction
- ❌ Removed: Examples from the prompt (but logic is the same)

## 2. Explanation Classifier Prompt

**Location**: `app.js` lines 3595-3657

**⚠️ IMPORTANT: This prompt has been SIGNIFICANTLY RELAXED compared to the review document!**

```
Task: Identify whether the following text belongs to the category "Explanation of Relevant Classroom Events."

Core Principle: An explanation connects observable classroom events with reasons WHY they occurred or WHY they matter for teaching and learning.

Key Question: Does the text explain WHY something happened in the classroom that relates to teaching or learning processes?

Code as "1" (Explanation) when the text contains:
* An observable classroom event (what teacher/students actually did)
* PLUS a reason WHY it happened or WHY it affects learning
* Even basic pedagogical reasoning counts
* Partial explanations are sufficient - if ANY part explains, code as "1"

Be INCLUSIVE - Accept these as explanations:
* Simple cause-effect statements about classroom dynamics
* Common-sense pedagogical reasoning without technical terms
* Connections between teaching actions and student responses
* Basic explanations of learning processes
* Informal observations about why teaching methods work/don't work

Code as "0" (Non-Explanation) only when:
* Text is purely descriptive with no causal reasoning
* Discusses hypothetical/future actions ("should have," "would have")
* Contains no WHY reasoning about actual classroom events
* Lacks any connection to teaching/learning processes

Positive Examples (Code as "1"):
* "The students were engaged because the activity was hands-on"
* "The teacher's open questions give students room for their own thoughts"
* "Through repetition, students can better remember the conjugations"
* "The unclear instructions confused the students"
* "Students don't participate because the teacher doesn't give them enough time to think"
* "Using role-play helps students remember vocabulary better"
* "The teacher goes through the rows to ensure all students are working"
* "By connecting to prior knowledge, learning becomes easier"
* "The negative feedback could discourage future participation"
* "Clear learning goals help students understand what's expected"

Negative Examples (Code as "0"):
* "The teacher writes the topic on the board"
* "Students work on the worksheet"
* "The classroom is noisy"
* "The teacher should have given more time"
* "I would have explained it differently"
* "The students seem tired"
* "Two newspaper articles are hanging on the board"
* "The lesson continues with the next exercise"
* "This happens in math class"
* "The teacher is male and middle-aged"

Remember:
* Focus on finding ANY explanatory content about WHY classroom events occur
* Don't require formal educational terminology
* Accept partial explanations within longer texts
* When uncertain, lean toward inclusion (code as "1")
* Look for connections between events and their effects on teaching/learning

Output only "1" or "0" without any additional text or quotation marks.

Text to be evaluated: {windowText}
```

**Major Differences from Review Document**:
- ❌ **Review doc requires**: "Links observable teaching events to educational knowledge", "References learning theories, teaching principles, or pedagogical concepts"
- ✅ **Code accepts**: "Simple cause-effect statements", "Common-sense pedagogical reasoning without technical terms", "Basic explanations of learning processes"
- ✅ **Code explicitly says**: "Be INCLUSIVE", "Don't require formal educational terminology", "When uncertain, lean toward inclusion (code as '1')"
- ✅ **Code has many examples** (10 positive, 10 negative)
- ⚠️ **This is a RELAXED/INCLUSIVE version** - much more lenient than the review document

## 3. Prediction Classifier Prompt

**Location**: `app.js` lines 3659-3689

```
You are an expert in analyzing teaching reflections. Determine if this text contains predictions about effects of teaching events on student learning.

DEFINITION: Predictions estimate potential consequences of teaching events for students based on learning theories.

CRITERIA FOR "1" (Contains Prediction):
- Predicts effects on student learning, motivation, or understanding
- Based on educational knowledge about learning
- Focuses on consequences for students
- Examples: "This feedback could increase motivation", "Students may feel confused"
- Must be relevant to teaching/learning context

CRITERIA FOR "0" (No Prediction):
- No effects on student learning mentioned
- Predictions without educational basis
- No connection to teaching events
- Predictions about non-learning outcomes
- Non-relevant content unrelated to teaching
- Too short or meaningless fragments

INSTRUCTIONS:
- Respond with ONLY "1" or "0"
- No explanations, quotes, or other text
- "1" if ANY part predicts effects on student learning
- "0" if no learning consequences mentioned OR if content is non-relevant
- Be conservative: only respond "1" if clearly certain

TEXT: {windowText}
```

**Differences from Review Document**:
- ✅ Added: "Must be relevant to teaching/learning context"
- ✅ Added: "Non-relevant content unrelated to teaching"
- ✅ Added: "Too short or meaningless fragments"
- ✅ Added: "Be conservative" instruction
- ❌ Removed: "STUDENT LEARNING EFFECTS INCLUDE" section (but logic is the same)

## Moving Window Approach

**Location**: `app.js` lines 3538-3566

- **Window Size**: 3 sentences per window
- **Overlap**: None (non-overlapping windows)
- **Minimum Length**: 20 characters per window
- **Window ID Format**: `chunk_001`, `chunk_002`, etc.

**Process**:
1. Split reflection into sentences
2. Group into windows of 3 sentences
3. Classify each window separately for D, E, P
4. Aggregate results across all windows

## Binary Classifier System Prompt

**Location**: `app.js` lines 3691-3706

```
You are an expert teaching reflection analyst. Be conservative in your classifications - only respond '1' if you are clearly certain the criteria are met. Respond with ONLY '1' or '0'.
```

**Settings**:
- Model: `gpt-4o`
- Temperature: `0.0` (deterministic)
- Max tokens: `10`
- Retries: 3 attempts if parsing fails

## Feedback Generation

**Location**: `app.js` lines 3829-3846

Feedback is generated **AFTER** evaluation, using:
- The aggregated percentages from binary classification
- The identified weakest component
- The reflection text itself

**Process**:
1. Evaluation completes → `analysisResult` with percentages
2. Both extended and short feedback generated in parallel
3. Both use the **same** `analysisResult` (ensures consistency)
4. Feedback prompts use the percentages and weakest component

## Summary

### What's Actually Used:
- ✅ Moving window approach (3 sentences per window)
- ✅ Three separate binary classification prompts
- ✅ Description prompt: Similar to review doc, with added conservatism checks
- ⚠️ **Explanation prompt: SIGNIFICANTLY RELAXED** - accepts common-sense reasoning, no formal theory required
- ✅ Prediction prompt: Similar to review doc, with added conservatism checks
- ✅ Feedback generation based on evaluation results

### Key Difference:
The **Explanation classifier is much more inclusive** than the review document suggests. It accepts:
- Simple cause-effect statements
- Common-sense reasoning (no technical terms needed)
- Basic explanations without formal theory
- Partial explanations

This makes it easier for students to get "Explanation" credit compared to the stricter review document version.
