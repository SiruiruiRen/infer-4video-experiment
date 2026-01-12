# Optimized Manuel Prompts for Code Implementation

## Overview

These are optimized versions of Manuel's prompts, maintaining the core requirements and structure but with reduced examples (5 positive + 5 negative) for faster evaluation.

---

## 1. DESCRIPTION CLASSIFIER (Optimized)

```
Task: Identify whether the following text belongs to the category "Description of Relevant Classroom Events."

Core Principle: Descriptions identify and differentiate observable classroom events based on educational knowledge, WITHOUT making evaluations, interpretations, or speculations.

Key Question: Has the person described relevant classroom events that provide insights into learning processes, learning activities, and/or teaching processes?

Definition: Descriptions identify and differentiate classroom events based on educational knowledge. Relevant events include both events initiated by teachers that affect student learning, and events initiated by students that are central to teacher action.

Code as "1" (Description) when the text contains:
* Identification and differentiation of observable classroom events
* Events relate to learning processes, learning activities, or teaching processes
* Uses neutral, observational language
* Events are observable (perceivable through senses, especially sight and hearing)

Code as "0" (Non-Description) when the text contains:
* Evaluations (indicators: "In my opinion...", "I think that...", "The teacher did well...")
* Interpretations (indicators: "This probably activates prior knowledge")
* Overgeneralizations (hasty conclusions based on few previous experiences)
* Speculations (indicators: "probably", "likely", use of subjunctive)
* Hypothetical or future actions (e.g., "I would have...", "If the teacher had done X/Y")
* Non-observable events (not perceivable through senses)
* Not about relevant classroom events

Coding Rules:
1. Be INCLUSIVE regarding relevant classroom events. If there are no concrete indicators that no relevant classroom event is described, assume a relevant event is present.
2. Consider only the individual segments - do not rely on prior knowledge from videos when coding.
3. A "1" is justified if parts of the text can be identified as "Description," even if other parts do not correspond to this category.

Positive Examples (Code as "1"):
1. "The teacher refers to the lesson topic: Binomial formulas"
2. "Students work on worksheets while the teacher walks through the rows"
3. "A student raises their hand"
4. "The teacher writes something on the board"
5. "The teacher goes through the rows"

Negative Examples (Code as "0"):
1. "The teacher probably wanted to activate prior knowledge" (speculation)
2. "I think the teacher did a good job explaining" (evaluation)
3. "The teacher should have given more time" (hypothetical action)
4. "The teacher probably wanted to..." (speculation/mutmaßung)
5. "The students seem tired" (interpretation, not observable)

Output only "1" or "0" without any additional text or quotation marks.

Text to be evaluated: {windowText}
```

---

## 2. EXPLANATION CLASSIFIER (Optimized)

```
Task: Identify whether the following text belongs to the category "Explanation of Relevant Classroom Events."

Core Principle: Explanations connect observable classroom events with theories of effective teaching, focusing on WHY events occur.

Key Question: Has the person explained relevant classroom events that provide insights into learning processes, learning activities, and/or teaching processes? Note: Explanations focus on the CAUSE perspective.

Definition: Explanations connect observable classroom events (what is being explained) with theories of effective teaching. The focus is on WHY an event occurs. The event being explained must be observable (perceivable through senses, especially sight and hearing).

Code as "1" (Explanation) when the text contains:
* An observable classroom event connected with concrete educational science knowledge to explain it
* Educational science knowledge includes: principles of cognitive activation, clarity of learning goals, use of advance organizers, learning psychology theories (self-determination theory, Bloom's taxonomy, constructivism, social-cognitive learning theory)
* The explanation relates to relevant classroom events (learning processes, learning activities, or teaching processes)
* The event being explained must be observable (not hypothetical or future actions)

Code as "0" (Non-Explanation) when the text contains:
* What is being explained is not observable (hypothetical or future actions, e.g., "I would have...", "If the teacher had done X/Y")
* Explanation without reference to a relevant classroom event
* Explanation without reference to educational science knowledge
* Pure description without theoretical connection

Coding Rules:
1. Causal connectors like "because" or "since" are neither necessary nor sufficient for an explanation.
2. Interpret the term "educational science knowledge" BROADLY. Be very INCLUSIVE here. Even if uncertainty exists about whether educational science knowledge is present, code inclusively.
3. The event being explained must be observable but need not be explicitly named (e.g., "learning goals" instead of "setting learning goals").
4. If uncertainty exists about whether a segment should be coded as Explanation or Prediction, assign it to the "Prediction" category (as the higher category).
5. A "1" is justified if parts of the text can be identified as "Explanation," even if other parts do not correspond to this category.

Positive Examples (Code as "1"):
1. "The teacher's open question should cognitively activate students"
2. "This connection links today's learning goal with prior knowledge"
3. "Because open questions give students room for their own thoughts"
4. "Through repetition, students can better remember the conjugations" (relates to learning theory)
5. "The unclear instructions confused the students" (connects event to learning effect)

Negative Examples (Code as "0"):
1. "Because the teacher communicated expectations" (no educational theory)
2. "The teacher should use different methods" (hypothetical event)
3. "The teacher writes the topic on the board" (pure description, no explanation)
4. "Students work on the worksheet" (pure description, no explanation)
5. "I would have explained it differently" (hypothetical/future action)

Output only "1" or "0" without any additional text or quotation marks.

Text to be evaluated: {windowText}
```

---

## 3. PREDICTION CLASSIFIER (Optimized)

```
Task: Identify whether the following text belongs to the category "Prediction."

Core Principle: Predictions estimate potential consequences of classroom events for students based on learning theories.

Key Question: Has the person predicted potential effects of relevant classroom events on the learning process of students? Note: Predictions focus on the CONSEQUENCE perspective.

Definition: Predictions estimate (possible, observable or non-observable) consequences of different classroom events for students based on learning theories.

Code as "1" (Prediction) when the text contains:
* Potential effects of relevant classroom events on student learning are predicted with reference to educational science knowledge about learning
* Predictions relate to relevant classroom events (learning processes, learning activities, or teaching processes)
* Effects on student learning, motivation, understanding, engagement, cognitive processes, emotional responses, academic performance, participation, retention
* Based on learning theories (interpreted broadly and inclusively)

Code as "0" (Non-Prediction) when the text contains:
* No effects on future student learning mentioned
* Prediction without reference to a classroom event
* Prediction without reference to educational science knowledge about learning
* Too vague or not connected to learning theory

Coding Rules:
1. Because it's about potential effects, statements about non-observable and future actions regarding consequences for student learning are allowed.
2. Use of subjunctive (e.g., "could") is neither necessary nor sufficient for a prediction.
3. If optional classroom events (e.g., other teacher actions) and their consequences for student learning are mentioned, these also count as predictions.
4. Interpret the term "learning theories" BROADLY. Be very INCLUSIVE here. Even statements like "This could increase motivation" are acceptable, even if not explicitly referring to a specific theory or model.
5. If uncertainty exists about whether a segment should be coded as Explanation or Prediction, assign it to the "Prediction" category (as the higher category).
6. A "1" is justified if parts of the text can be identified as "Prediction," even if other parts do not correspond to this category.

Positive Examples (Code as "1"):
1. "Teacher feedback could increase student learning motivation"
2. "This questioning strategy may help students identify knowledge gaps"
3. "Through this feedback, the students' learning motivation could grow"
4. "Following self-determination theory, stronger autonomy experience with tasks likely leads to stronger intrinsic motivation"
5. "This feedback could discourage future participation" (negative effect, but still a prediction about learning)

Negative Examples (Code as "0"):
1. "This creates a good working climate" (too vague, no learning theory)
2. "The teacher will continue the lesson" (no student learning effect)
3. "The students were engaged because..." (this is explanation, not prediction)
4. "The teacher writes on the board" (description, no prediction)
5. "This could be better" (too vague, no learning theory connection)

Output only "1" or "0" without any additional text or quotation marks.

Text to be evaluated: {windowText}
```

---

## Key Features Maintained from Manuel's Prompts

1. ✅ **Educational Theory Requirement**: Explanation requires connection to educational science knowledge
2. ✅ **Inclusivity Rules**: Explicit coding rules for inclusive interpretation
3. ✅ **Observable Events**: Clear requirement that events must be observable
4. ✅ **Coding Rules**: All important coding rules preserved
5. ✅ **Structure**: Definition → Characteristics → Examples → Coding Rules → Instructions

## Optimizations Made

1. ✅ **Reduced Examples**: From 20-25 examples to 5 positive + 5 negative (most representative)
2. ✅ **Streamlined Language**: More concise while maintaining clarity
3. ✅ **English Translation**: Translated from German for code implementation
4. ✅ **Maintained Core**: All critical requirements and coding rules preserved

## Next Steps

These prompts should replace the current prompts in:
- `infer-study-alpha/app.js`
- `infer-study-beta/app.js`
- `infer-study-gamma/app.js`

The Explanation classifier will now require educational theory connection (like Manuel's), making it more aligned with research standards.
