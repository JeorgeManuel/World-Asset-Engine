# World Asset Engine

The **World Asset Engine** explores a system where players can own in-game assets as NFTs and have those assets **rendered natively across different games and worlds**.  
Instead of forcing a single universal asset format, the engine uses a **machine-learning–enhanced interpreter** to imagine how an asset should exist within the rules, logic, and aesthetics of each target world.

## Overview

This repository contains **experimental scripts and prototypes** developed during the **Node Engine Hackathon**.  
Due to the short development timeframe, the project is **incomplete** and **non-production ready**, but it serves as a **conceptual and technical foundation** for future development.

Each directory focuses on a specific subsystem that was intended to be demonstrated during the hackathon.

## Repository Structure

### `nft-api/`
Experiments with accessing NFTs through existing infrastructure providers (e.g. Alchemy).

- Uses third-party APIs to:
  - Query NFT metadata
  - Verify asset ownership
- Intended to avoid building blockchain infrastructure from scratch during the demo phase

### `nft-marketplace/`
An early attempt at designing a custom NFT marketplace from scratch.

- This approach was later abandoned due to time constraints
- Kept in the repo for reference and future exploration

### `Terminal_application/`
An in-game terminal interface used to interact with NFT services via API calls.

- Built on top of an open-source Godot terminal emulator
- Designed to function as an **in-world UI** for querying assets and ownership
- Terminal commands act as modular add-on applications that perform HTTP requests

Original terminal project:  
https://github.com/joryleech/Godot-Terminal

### `Docs/`
Design documentation and conceptual proposal for the full World Asset Engine.

- Describes a future system powered by a **sequence-to-sequence model**
- The model interprets:
  - How an asset should exist in a given world
  - Which characteristics of an asset should be stored as NFT metadata
- Focuses on *native world embodiment* rather than direct asset portability

## Demo Worlds Used

Two unrelated open-source games were selected to demonstrate how the same conceptual asset could exist differently across worlds:

- **2D RPG**  
  https://github.com/akrck02/linus-tiny-adventure.git

- **3D First-Person Shooter**  
  https://github.com/AxelReviron/Godot-FPS-Template.git

These worlds were chosen specifically to highlight **cross-genre interpretation** rather than visual similarity.

## Status

🚧 **Experimental / Hackathon Prototype**

- Not feature complete
- Not production ready
- Actively exploratory by design

The goal of this repository is to **validate the core idea** of cross-world asset embodiment and provide a launch point for deeper research and development.

## YouTube Presentation

A short presentation and conceptual demo explaining the motivation, architecture, and hackathon prototype can be found here:

🎥 **World Asset Engine – Hackathon Presentation**  
https://youtu.be/EiWCyFoWdyk

This presentation reflects the **conceptual and exploratory state** of the project during the Node Engine Hackathon.


## Vision

Long-term, the World Asset Engine aims to enable:

- True cross-game digital ownership
- World-native asset reinterpretation
- A shared infrastructure for interoperable virtual worlds

Built to imagine assets **as ideas**, not files.
