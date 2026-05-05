# Gen~ Learning Path Design

**Date:** 2026-05-05  
**Duration:** 12-16 weeks  
**Time commitment:** 5-10 hours/week  
**Learning style:** Theory → Practice Pipeline  
**Goal:** Comprehensive mastery of Gen~ for synthesis and audio effects

## Overview

A structured progression through DSP concepts and Gen~ implementation. Each 2-week cycle: learn theory deeply, code the concept in Gen~, build variations. Designed for solid programmers new to DSP who want equal balance of theory and hands-on coding.

## Learning Approach: Theory → Practice Pipeline

**Cycle structure (repeats 8-10 times):**

1. **Theory Phase** (1-1.5 hours)
   - Study ONE DSP concept deeply
   - Understand the why, not just implementation
   - Resources: official Gen~ docs + DSP theory sources

2. **Implementation Phase** (1.5-2 hours)
   - Code the concept in Gen~ from scratch
   - Build working audio patches
   - Test and iterate

3. **Variation Phase** (1-1.5 hours)
   - Modify and extend the implementation
   - Combine with previous concepts
   - Create unique applications

## Curriculum Progression

### Weeks 1-2: Signal Flow & Basic Math
**Theory:** Sample rate, Nyquist frequency, amplitude normalization, signal routing  
**Resources:** Cycling '74 Gen~ primer, "The DSP Dimension"  
**Build:** Simple amplitude scaler with envelope, MIDI-to-frequency mapping  
**Practice:** Parameter normalization (0-127 MIDI → 20-20000 Hz)

### Weeks 3-4: Delay Lines & Feedback
**Theory:** Delay as memory, `history` operator, feedback loops, stability conditions  
**Resources:** Julius Smith's "Physical Audio Signal Processing", Gen~ delay examples  
**Build:** Feedback delay patch with adjustable delay time and feedback  
**Practice:** Resonant delay near stability limit, stereo ping-pong delay

### Weeks 5-6: Filters (Biquad)
**Theory:** Frequency response, poles/zeros, biquad design, Q factor  
**Resources:** "The Art of VA Filter Design" (Välimäki), Gen~ filter examples  
**Build:** Biquad lowpass filter from scratch, sweep cutoff frequency  
**Practice:** Highpass and bandpass filters, cascade filters for steeper slopes

### Weeks 7-8: Oscillators & Waveforms
**Theory:** Nyquist limit, band-limited synthesis, wavetable lookup, phase accumulation  
**Resources:** "Antialiased Oscillators Using Integrated Bandlimited Tables", Gen~ examples  
**Build:** Sine oscillator with phase accumulation, waveform folding (square/sawtooth)  
**Practice:** Wavetable oscillator with interpolation, aliasing prevention

### Weeks 9-10: Modulation & LFOs
**Theory:** Amplitude modulation (AM), frequency modulation (FM), ring modulation  
**Resources:** "Computer Music Tutorial" (Dodge/Jerse), FM synthesis papers  
**Build:** FM synthesizer with modulation index control  
**Practice:** AM synthesis, ring modulation, LFO modulation of filter cutoff

### Weeks 11-12: Full Synthesis
**Theory:** Subtractive synthesis architecture, envelope generation, signal combining  
**Resources:** Mutable Instruments open-source code, Gen~ synth examples  
**Build:** Complete subtractive synth (oscillator → filter → amplifier with envelopes)  
**Practice:** Polyphonic voice handling, MIDI integration, creative parameter modulation

### Weeks 13+: Custom Algorithms (Choose Your Path)
**Options:** Waveshaper design, physical modeling, granular synthesis, spectral processing  
**Approach:** Study DSP papers, implement in Gen~, create custom effects/synthesizers

## Weekly Workflow

**Monday: Theory** (1-1.5 hours)
- Read theory materials
- Take notes on key equations and concepts
- Sketch signal flow diagrams

**Wednesday: Implementation** (1.5-2 hours)
- Build Gen~ patch from scratch
- Test with audio input/output
- Debug and iterate

**Friday/Weekend: Variations** (1-1.5 hours)
- Modify and extend the patch
- Combine with previous concepts
- Experiment and explore

## Resources

**Primary:**
- Cycling '74 Gen~ Documentation (official reference)
- Julius Smith's Physical Audio Signal Processing (free online)
- Gen~ Community examples (GitHub)

**Secondary:**
- Mutable Instruments source code (reference implementations)
- Max community forum and Discord
- DSP textbooks: "The Art of VA Filter Design", "Computer Music Tutorial"

## Success Criteria

**Weekly:**
- Working Gen~ patch that produces sound
- Clear understanding of the core DSP concept
- Documented code with signal flow comments

**Monthly:**
- Deep comprehension of 2-3 DSP concepts
- Ability to explain theory and implementation
- Growing library of reusable Gen~ patterns

**End Goal:**
- Can build custom synthesizers from DSP papers
- Understand signal flow at the sample level
- Comfortable extending and combining Gen~ patches
- Foundation for advanced audio DSP work

## Documentation & Learning Log

- Keep a weekly learning log (theory notes, code comments, discoveries)
- Save working patches with clear comments
- Record audio examples of what you built each week
- Document surprises, failures, and insights

## Success Metrics

- Weeks 1-2: Understand signal normalization and basic Gen~ syntax
- Weeks 3-4: Build stable feedback delay, understand history operator
- Weeks 5-6: Implement biquad filter, sweep parameters musically
- Weeks 7-8: Create interesting oscillator variations
- Weeks 9-10: FM synthesis with expressive modulation
- Weeks 11-12: Polyphonic subtractive synth working
- Weeks 13+: Custom algorithm of your choice implemented and musical
