# FirstDApp_Repo_Bounty

Smart Contract Enhancements: Quest Review Functionality and Quest Start/End Times

Features Overview:
The two additional features added to the smart contract are quest review functionality and quest start/end times. These features aim to mimic StackUp's functionalities more closely and enhance user engagement and fairness within the quest system.

Quest Review Functionality:
The quest review functionality enables the contract's admin to manage player submissions by approving, rejecting, or rewarding them. It introduces a new enumeration type, SubmissionStatus, and a mapping, playerSubmissionStatuses, to store the submission status for each player's quest submission. The admin can use the reviewSubmission function to update the submission status for a specific player's quest. This feature allows the admin to provide feedback and rewards to players based on their submissions, increasing interactivity and motivation within the quest system.

Quest Start/End Times:
The quest start and end times feature adds time-based restrictions to quest participation. Each quest struct now includes startTime and endTime properties, representing the quest's time window. The joinQuest and submitQuest functions are modified with the withinQuestTime modifier, which verifies if the current time is within the quest's start and end times before allowing a player to join or submit the quest. This feature ensures fairness by preventing players from joining or submitting quests that have already ended. It also introduces a sense of urgency and time-based challenges, aligning with StackUp's functionalities.

These additional features enhance the smart contract by introducing review capabilities for quest submissions and time-based restrictions for quest participation, enriching the user experience and promoting fairness and engagement within the quest system.
