import sys

probability_reward_matrix = {
  "exercise": {
    "fit": {
      "fit": (0.9, 8),
      "unfit": (0.01, 8),
      "dead": (0.1, 0),
    },
    "unfit": {
      "fit": (0.2, 0),
      "unfit": (0.8, 0),
      "dead": (0.1, 0),
    },
    "dead": {
      "fit": (0, 0),
      "unfit": (0, 0),
      "dead": (1, 0),
    }
  },
  "relax": {
    "fit": {
      "fit": (0.7, 10),
      "unfit": (0.3, 10),
      "dead": (0.01, 0),
    },
    "unfit": {
      "fit": (0, 5),
      "unfit": (1, 5),
      "dead": (0.01, 0),
    },
    "dead": {
      "fit": (0, 0),
      "unfit": (0, 0),
      "dead": (1, 0),
    }
  }
}

States = ["fit", "unfit", "dead"]
Actions = ["relax", "exercise"]

def probability_of(state, action, next_state):

    return probability_reward_matrix[action][state][next_state][0]

def reward_for(state, action, next_state):

    return probability_reward_matrix[action][state][next_state][1]

# Calculate Vn(s) = max(qn(s,'exercise'), qn(s,relax))
def gamma_adjusted_reward(n, gamma, state):

  exercise_q_val = q(n, gamma, state, "exercise")
  relax_q_val = q(n, gamma, state, "relax")

  if exercise_q_val > relax_q_val:
    return exercise_q_val
  else:
    return relax_q_val

# Calculate Vn(s) = max(qn(s,'exercise'), qn(s,relax))
def q(n, gamma, state, action):

  # Base case q0
  if n == 0:
    q_val = 0

    for next_state in States:
      prob = probability_of(state, action, next_state)
      reward = reward_for(state, action, next_state)
      q_val = q_val + prob * reward

    return q_val

  # If n > 0
  q_val = 0
  q0 = q(0, gamma, state, action)

  for next_state in States:
    prob = probability_of(state, action, next_state)
    reward = gamma_adjusted_reward(n-1, gamma, next_state)
    q_val = q_val + prob * reward

  return q0 + gamma * q_val

if len(sys.argv) == 4:
    n = int(sys.argv[1])
    gamma = float(sys.argv[2])
    s = sys.argv[3]

    print "State: ", s
    print "Exercise: ", q(n, gamma, s, "exercise")
    print "Relax: ", q(n, gamma, s, "relax"), "\n"
else:
    print("Enter arguments (n, gamma, state) in form:\n python3 markov.py n gamma state")
    print("(Available states: fit, unfit, dead)")
