#!/bin/bash
# Test script for post_todo_reflector hook

echo "Testing post-todo hook..."

# Create a mock hook input JSON
cat <<EOF | /Users/maratyuldashev/work/marat_ai/claude_marat_ai/hooks/post_todo_reflector.sh
{
  "session_id": "test-session-123",
  "hook_event_name": "PostToolUse",
  "tool_name": "TodoWrite",
  "tool_input": {
    "todos": [
      {
        "content": "Test task",
        "status": "completed",
        "activeForm": "Testing task"
      }
    ]
  },
  "tool_response": "Success",
  "cwd": "/Users/maratyuldashev/work/marat_ai",
  "transcript_path": "/tmp/test_transcript.txt"
}
EOF

echo ""
echo "Hook execution completed. Check stderr output above for status."
